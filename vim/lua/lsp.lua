-- lspconfig object
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    -- require'completion'.on_attach(client)
    require'virtualtypes'.on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Enable rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable hls (Haskell)
lspconfig.hls.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable python-language-server (Python)
lspconfig.pylsp.setup({
    capabilities=capabilities;
    on_attach=on_attach;
    settings = {
        pyls = {
            configurationSources = { "flake8" } -- reads ~/.config/flake8
            }
        }
})

-- Enable vscode language servers (HTML, CSS, JSON)
lspconfig.cssls.setup({ capabilities=capabilities; on_attach=on_attach })
lspconfig.html.setup({ capabilities=capabilities; on_attach=on_attach })
lspconfig.jsonls.setup({ capabilities=capabilities; on_attach=on_attach; cmd={"json-languageserver", "--stdio"} })

-- Enable flow (JavaScript)
lspconfig.flow.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable typescript language server (Typescript)
lspconfig.tsserver.setup({
    on_attach=function(client, _)
        on_attach(client)

        require("nvim-lsp-ts-utils").setup {}
    end,
    capabilities=capabilities
})

-- Enable bashls (Bash)
lspconfig.bashls.setup({
    capabilities=capabilities;
    -- on_attach=on_attach
})

-- Enable vim-language-server (vimscript)
lspconfig.vimls.setup({
    capabilities=capabilities;
    -- on_attach=on_attach
})

-- Enable Vue Language Server (Vue.js)
lspconfig.vuels.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable Clangd (C/C++)
lspconfig.clangd.setup({
    capabilities=capabilities;
    -- on_attach=on_attach
})

-- Enable lua-language-server (Lua)
lspconfig.sumneko_lua.setup({
    capabilities=capabilities;
    -- on_attach=on_attach;
    cmd = { "/bin/lua-language-server", "-E", vim.fn.stdpath('cache').."/lspconfig/sumneko_lua/lua-language-server/main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
})
