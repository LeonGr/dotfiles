-- configure diagnostics
vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- set inline diagnostics prefix
vim.diagnostic.config({
    virtual_text = {
        prefix = "!",
    },
})

-- lspconfig object
local lspconfig = require'lspconfig'

-- add popup border
require('lspconfig.ui.windows').default_options.border = 'single'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(_)
    require'virtualtypes'.on_attach()
end

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.completion.completionItem.snippetSupport = true
client_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)

vim.lsp.inlay_hint.enable()

-- Enable hls (Haskell)
lspconfig.hls.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable python-language-server (Python)
lspconfig.pylsp.setup({
    capabilities=capabilities;
    on_attach=on_attach;
    settings = {
        pylsp = {
            configurationSources = { "flake8" } -- reads ~/.config/flake8
        }
    }
})

-- Enable vscode language servers (HTML, CSS, JSON)
lspconfig.cssls.setup({ capabilities=capabilities; on_attach=on_attach })
lspconfig.html.setup({ capabilities=capabilities; on_attach=on_attach; filetypes = { "html", "blade" } })
lspconfig.jsonls.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable flow (JavaScript)
lspconfig.flow.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable jdtls (Java)
local jdtls = require('jdtls')

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.java" },
    callback = function()
        local bundles = {
            vim.fn.glob(os.getenv("HOME") .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar')
        }

        local config = {
            cmd = {os.getenv("HOME") .. '/.local/share/nvim/mason/bin/jdtls'},
            root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
            on_attach = function()
                -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
                -- you make during a debug session immediately.
                -- Remove the option if you do not want that.
                jdtls.setup_dap({
                    -- hotcodereplace = 'auto'
                })
                jdtls.setup.add_commands()
            end,
            init_options = {
                bundles = bundles
            },
            settings = {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-19",
                                path = '/usr/lib/jvm/java-19-openjdk/'
                            }
                        }
                    }
                }
            }
        }

        jdtls.start_or_attach(config)

        -- find launch.json
        require('dap.ext.vscode').load_launchjs()
    end,
})

-- Enable typescript language server (Typescript)
lspconfig.ts_ls.setup({
    on_attach=function(client, _)
        on_attach(client)

        require("nvim-lsp-ts-utils").setup {}
    end,
    capabilities=capabilities
})

-- Enable bashls (Bash)
lspconfig.bashls.setup({ capabilities=capabilities })

-- Enable vim-language-server (vimscript)
lspconfig.vimls.setup({ capabilities=capabilities })

-- Enable Vue Language Server (Vue.js)
lspconfig.volar.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable Clangd (C/C++)
lspconfig.clangd.setup({ capabilities=capabilities })

-- Enable lua-language-server (Lua)
lspconfig.lua_ls.setup({
    capabilities=capabilities;
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

-- Enable gopls (golang)
lspconfig.gopls.setup({ capabilities=capabilities })

-- Enable phpactor (PHP)
lspconfig.phpactor.setup({ capabilities=capabilities })

-- Enable nil_ls (Nix Expression Language)
require'lspconfig'.nil_ls.setup{}

-- Enable fish_lsp (fish shell language)
-- Error codes: https://github.com/ndonfris/fish-lsp/wiki/Diagnostic-Error-Codes
lspconfig.fish_lsp.setup({ capabilities=capabilities })
