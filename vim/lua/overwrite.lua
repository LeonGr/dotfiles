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
--local border_juncleft   = "╠"
--local border_juncright  = "╣"

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "double"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "double"
  }
)

local if_nil = vim.F.if_nil
local api = vim.api

-- add border to diagnostics
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
