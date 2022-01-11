-- configure diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

-- set inline diagnostics prefix
vim.diagnostic.config({
    virtual_text = {
        prefix = "",
    },
})

-- local border_vertical   = "║"
-- local border_horizontal = "═"
-- local border_topleft    = "╔"
-- local border_topright   = "╗"
-- local border_botleft    = "╚"
-- local border_botright   = "╝"
-- local border_juncleft   = "╠"
-- local border_juncright  = "╣"

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single"
  }
)
