-- lspconfig object
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

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

-- Enable rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({ on_attach=on_attach })

-- Enable hls (Haskell)
lspconfig.hls.setup({ on_attach=on_attach })

-- Enable python-language-server (Python)
lspconfig.pyls.setup({
    on_attach=on_attach;
    settings = {
        pyls = {
            configurationSources = { "flake8" } -- reads ~/.config/flake8
            }
        }
})

-- Enable vscode language servers (HTML, CSS, JSON)
lspconfig.cssls.setup({ on_attach=on_attach })
lspconfig.html.setup({ on_attach=on_attach })
lspconfig.jsonls.setup({ on_attach=on_attach; cmd={"json-languageserver", "--stdio"} })

-- Enable flow (JavaScript)
lspconfig.flow.setup({ on_attach=on_attach })

-- Enable typescript language server (Typescript)
lspconfig.tsserver.setup({ on_attach=on_attach })

-- Enable bashls (Bash)
lspconfig.bashls.setup({ on_attach=on_attach })

-- Enable vim-language-server (vimscript)
lspconfig.vimls.setup({ on_attach=on_attach })

-- Enable Vue Language Server (Vue.js)
lspconfig.vuels.setup({ on_attach=on_attach })

-- Enable Clangd (C/C++)
lspconfig.clangd.setup({ on_attach=on_attach })

