-- configure diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

-- overwrite inline diagnostic function (virtual_text)
vim.lsp.diagnostic.get_virtual_text_chunks_for_line = function(bufnr, line, line_diags, opts)
  assert(bufnr or line)

  if #line_diags == 0 then
    return nil
  end

  opts = opts or {}
  local prefix = ""
  local spacing = 1

  local get_highlight = vim.lsp.diagnostic._get_severity_highlight_name

  -- Create a little more space between virtual text and contents
  local virt_texts = {{string.rep(" ", spacing)}}

  for i = 1, #line_diags - 1 do
    table.insert(virt_texts, {prefix, get_highlight(line_diags[i].severity)})
  end
  local last = line_diags[#line_diags]

  if last.message then
    table.insert(
      virt_texts,
      {
        --string.format("%s %s", prefix, last.message:gsub("\r", ""):gsub("\n", "  ")),
        string.format("%s", prefix),
        get_highlight(last.severity)
      }
    )

    return virt_texts
  end
end

local border_vertical   = "║"
local border_horizontal = "═"
local border_topleft    = "╔"
local border_topright   = "╗"
local border_botleft    = "╚"
local border_botright   = "╝"
local border_juncleft   = "╠"
local border_juncright  = "╣"

local api = vim.api
local validate = vim.validate
vim.lsp.util.fancy_floating_markdown = function(contents, opts)
    validate {
        contents = { contents, 't' };
        opts = { opts, 't', true };
    }
    opts = opts or {}

    --split lines that are too long
    local columns = api.nvim_get_option('columns')
    local popup_max_width = math.floor(columns - (columns * 2 / 10))

    local stripped_max_width = {}

    for i, line in ipairs(contents) do
        line = line:gsub("\r", "")
        line = line:gsub(" ```ts", "```typescript")
        line = line:gsub(" ```", "```")
        local len = line:len()
        if len == 0 and i < #contents and contents[i+1]:len() == 0 then

        elseif len > popup_max_width then
            for j=1,math.ceil(len / popup_max_width) do
                table.insert(stripped_max_width, string.sub(line, 1 + ((j-1) * popup_max_width), (j * popup_max_width)))
            end
        else
            table.insert(stripped_max_width, line)
        end
    end

    contents = stripped_max_width

    local stripped = {}
    local highlights = {}
    do
        local i = 1
        while i <= #contents do
            local line = contents[i]
            -- TODO(ashkan): use a more strict regex for filetype?
            local ft = line:match("^```([a-zA-Z0-9_]*)$")
            -- local ft = line:match("^```(.*)$")
            -- TODO(ashkan): validate the filetype here.
            if ft then
                local start = #stripped
                i = i + 1
                while i <= #contents do
                    line = contents[i]
                    if line == "```" then
                        i = i + 1
                        break
                    end
                    table.insert(stripped, line)
                    i = i + 1
                end
                table.insert(highlights, {
                    ft = ft;
                    start = start + 1;
                    finish = #stripped + 1 - 1;
                })
            else
                table.insert(stripped, line)
                i = i + 1
            end
        end
    end
    -- Clean up and add padding
    stripped = vim.lsp.util._trim_and_pad(stripped, opts)

    local max_length = 0
    for _, line in ipairs(stripped) do
        local len = line:len()
        if len > max_length then
            max_length = len
        end
    end

    -- pad lines with spaces so they are all the same length
    for i, line in ipairs(stripped) do
        line = line:gsub("\r", "")
        -- these have double width or something
        line = line:gsub("—", "-")
        line = line:gsub("–", "-")
        line = line:gsub("·", ".")
        local len = line:len()
        stripped[i] = string.format('%s%s%s%s', border_vertical, line, string.rep(" ", max_length - len), border_vertical)
    end

    -- Compute size of float needed to show (wrapped) lines
    opts.wrap_at = opts.wrap_at or (vim.wo["wrap"] and api.nvim_win_get_width(0))
    local width, height = vim.lsp.util._make_floating_popup_size(stripped, opts)

    -- Insert blank line separator after code block
    local insert_separator = opts.separator
    if insert_separator == nil then insert_separator = true end
    if insert_separator then
        for i, h in ipairs(highlights) do
            h.start = h.start + i - 1
            h.finish = h.finish + i - 1
            if h.finish + 1 <= #stripped then
                table.insert(stripped, h.finish + 1, border_juncleft..string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))..border_juncright)
                height = height + 1
            end
        end
    end

    -- add borders
    table.insert(stripped, 1, border_topleft..string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))..border_topright)
    table.insert(stripped, border_botleft..string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))..border_botright)
    height = height + 2

    -- Make the floating window.
    local bufnr = api.nvim_create_buf(false, true)
    local winnr = api.nvim_open_win(bufnr, false, vim.lsp.util.make_floating_popup_options(width, height, opts))
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, stripped)
    api.nvim_buf_set_option(bufnr, 'modifiable', false)

    -- Switch to the floating window to apply the syntax highlighting.
    -- This is because the syntax command doesn't accept a target.
    local cwin = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(winnr)

    vim.cmd("ownsyntax markdown")
    local idx = 1
    --@private
    local function apply_syntax_to_region(ft, start, finish)
        if ft == '' then return end
        local name = ft..idx
        idx = idx + 1
        local lang = "@"..ft:upper()
        -- TODO(ashkan): better validation before this.
        if not pcall(vim.cmd, string.format("syntax include %s syntax/%s.vim", lang, ft)) then
            return
        end
        vim.cmd(string.format("syntax region %s start=+\\%%%dl+ end=+\\%%%dl+ contains=%s", name, start, finish + 1, lang))
    end
    -- Previous highlight region.
    -- TODO(ashkan): this wasn't working for some reason, but I would like to
    -- make sure that regions between code blocks are definitely markdown.
    -- local ph = {start = 0; finish = 1;}
    for _, h in ipairs(highlights) do
        -- apply_syntax_to_region('markdown', ph.finish, h.start)
        apply_syntax_to_region(h.ft, h.start, h.finish)
        -- ph = h
    end

    vim.api.nvim_set_current_win(cwin)
    return bufnr, winnr
end


local if_nil = vim.F.if_nil

vim.lsp.diagnostic.show_line_diagnostics = function(opts, bufnr, line_nr, client_id)
    opts = opts or {}
    opts.severity_sort = if_nil(opts.severity_sort, true)

    local show_header = if_nil(opts.show_header, true)

    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

    local lines = {}
    local highlights = {}
    if show_header then
        table.insert(lines, "Diagnostics:")
        table.insert(highlights, {0, "Bold"})
    end

    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    if vim.tbl_isempty(line_diagnostics) then return end

    for i, diagnostic in ipairs(line_diagnostics) do
        local prefix = string.format("%d. ", i)
        local hiname = vim.lsp.diagnostic._get_floating_severity_highlight_name(diagnostic.severity)
        assert(hiname, 'unknown severity: ' .. tostring(diagnostic.severity))

        local message_lines = vim.split(diagnostic.message, '\n', true)

        local columns = api.nvim_get_option('columns')
        local popup_max_width = math.floor(columns - (columns * 2 / 10))
        local stripped_max_width = {}

        for _, line in ipairs(message_lines) do
            local len = line:len()

            if len > popup_max_width then
                for j=1,math.ceil(len / popup_max_width) do
                    table.insert(stripped_max_width, string.sub(line, 1 + ((j-1) * popup_max_width), (j * popup_max_width)))
                end
            else
                table.insert(stripped_max_width, line)
            end
        end

        message_lines = stripped_max_width

        table.insert(lines, prefix..message_lines[1])
        table.insert(highlights, {#prefix + 1, hiname})
        for j = 2, #message_lines do
            table.insert(lines, message_lines[j])
            table.insert(highlights, {2, hiname})
        end
    end

    local max_length = 0

    for _, line in ipairs(lines) do
        local len = line:len()
        if len > max_length then
            max_length = len
        end
    end

    for i, line in ipairs(lines) do
        local len = line:len()
        lines[i] = string.format('%s%s%s%s', border_vertical, line, string.rep(" ", max_length - len), border_vertical)
    end

    table.insert(lines, 1, border_topleft..string.rep(border_horizontal, max_length)..border_topright)
    table.insert(lines, border_botleft..string.rep(border_horizontal, max_length)..border_botright)

    local popup_bufnr, winnr = vim.lsp.util.open_floating_preview(lines, 'plaintext')
    for i, hi in ipairs(highlights) do
        local prefixlen, hiname = unpack(hi)
        -- Start highlight after the prefix
        api.nvim_buf_add_highlight(popup_bufnr, -1, hiname, i, prefixlen+2, max_length + 4)
    end

    return popup_bufnr, winnr
end
