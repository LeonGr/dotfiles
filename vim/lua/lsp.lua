-- lspconfig object
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

-- add popup border
require('lspconfig.ui.windows').default_options.border = 'single'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
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

-- Enable rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({ capabilities=capabilities })

local rust_tools = require('rust-tools')

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
-- From https://sharksforarms.dev/posts/neovim-rust/
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
      -- parameter_hints_prefix = "",
      -- other_hints_prefix = "",
    },
    reload_workspace_from_cargo_toml = true,
      hover_actions = {
          auto_focus = true,
      }
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = function(client, bufnr)
        on_attach(client)

        -- Hover actions
        vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    end,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
          extraArgs = {"--", "-W", "clippy::pedantic"},
        },
        procMacro = {
            enable = true,
        },
        cargo = {
            allFeatures = true;
        }
      },
    },
  },
  -- debugging
  dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        'codelldb',
        '/lib/liblldb.so'
      )
  },
}

-- Enable rust-tools
rust_tools.setup(opts)

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
lspconfig.jsonls.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable flow (JavaScript)
lspconfig.flow.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable jdtls (Java)
lspconfig.jdtls.setup({ capabilities=capabilities; on_attach=on_attach })

-- Enable typescript language server (Typescript)
lspconfig.tsserver.setup({
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
lspconfig.sumneko_lua.setup({
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
