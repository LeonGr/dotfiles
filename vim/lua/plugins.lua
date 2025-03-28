-- configure plugins
local plugins = {
    -- Misc
    'tpope/vim-surround',                                                   -- Wrap text easily
    { 'mattn/emmet-vim',                                                    -- html autocomplete
        ft = { "html", "vue" }
    },
    'scrooloose/nerdcommenter',                                             -- Easy commenting and uncommenting
    'tpope/vim-obsession',                                                  -- Save vim sessions
    'aserowy/tmux.nvim',                                                    -- Neovim tmux integration
    { 'unblevable/quick-scope',                                             -- Higlight words when you press f or t
      event = 'VeryLazy' },
    'chip/vim-fat-finger',                                                  -- Series of abbreviations for vim
    'tpope/vim-repeat',                                                     -- Repeat more than one command
    'godlygeek/tabular',                                                    -- Easy text align
    'nvim-lua/plenary.nvim',                                                -- Library that wraps neovim functions
    'dense-analysis/ale',                                                   -- Async Lint Engine
    'KabbAmine/vCoolor.vim',                                                -- Colour picker (Alt-Z)
    'yaroot/vissort',                                                       -- Sort by visual block
    'norcalli/nvim-colorizer.lua',                                          -- Color highlighter
    'nathanaelkane/vim-indent-guides',                                      -- Indentation guides
    'LeonGr/neovim-expand-selection',                                       -- My own plugin
    'janko-m/vim-test',                                                     -- Vim wrapper for running tests
    'windwp/nvim-autopairs',                                                -- Auto pairs
    'xiyaowong/nvim-cursorword',                                            -- Underline the word under the cursor
    { 'gelguy/wilder.nvim', build = ":UpdateRemotePlugins" },               -- command-line completion tweaks
    'nvim-lua/popup.nvim',                                                  -- vim compatible popups in neovim
    'glepnir/galaxyline.nvim',                                              -- Lua Statusline
    {'akinsho/bufferline.nvim',                                             -- Lua Bufferline
        dependencies = 'nvim-tree/nvim-web-devicons'                        -- filetype icons for plugins (e.g. telescope)
    },
    { 'iamcco/markdown-preview.nvim', build = "cd app && yarn"  },          -- Markdown preview (:MarkdownPreview)
    { 'henriklovhaug/Preview.nvim',
        cmd = { "Preview" },
        config = function() require("preview").setup() end, },
    'stevearc/dressing.nvim',                                               -- Allow overriding UI hooks (used for RustRunnables w/ Telescope)
    { 'mistricky/codesnap.nvim', build = "make build_generator" },          -- Take pretty screenshots of code
    { 'j-hui/fidget.nvim', opts = {}, },                                    -- Pretty notifications + LSP status
    { 'nvim-pack/nvim-spectre',                                             -- Search and replace panel
        dependencies = 'nvim-lua/plenary.nvim'
    },
    'nvim-tree/nvim-tree.lua',                                              -- file tree
    { 'smoka7/hop.nvim',                                                    -- quick jumping to the entire visible text
        version = "*", opts = { keys = 'etovxqpdygfblzhckisuran' },         -- Amp-like / Helix-like
        keys = {
            { "gh", ":HopWord<cr>" },
        },
    },
    { 'jake-stewart/force-cul.nvim',                                        -- Force cursorline highlight on signs
        config = function()
            require("force-cul").setup()
        end
    },
    { 'echasnovski/mini.ai', version = '*' },                               -- Extend and create a/i (all/in) textobjects
    { 'junegunn/fzf.vim',                                                   -- Fuzzy finder
        dependencies = {
            'junegunn/fzf',
            build = ":call fzf#install()",
        },
    },


    -- debugging
    {'mfussenegger/nvim-dap',                                               -- Debug Adapter Protocol (DAP) client implementation
        dependencies = {
            { 'rcarriga/nvim-dap-ui',                                       -- UI for nvim-dap
                dependencies = {
                    'nvim-neotest/nvim-nio'                                 -- A library for asynchronous IO in Neovim
                },
        },
            'theHamsta/nvim-dap-virtual-text',                              -- Variable values as virtual text
        },
        ft = { "rust", "c", "cpp", "python", "java" },
    },
    {'mfussenegger/nvim-jdtls',                                             -- Debug Adapter Protocol (DAP) client implementation for Java
        ft = { "java" },
    },
    {'mfussenegger/nvim-dap-python',                                        -- Debug Adapter Protocol (DAP) client implementation for Python
        ft = { "python" },
    },

    -- mason
    { 'williamboman/mason.nvim',                                            -- Package manager for neovim LSP servers, DAP servers, etc.
        dependencies = {
            'williamboman/mason-lspconfig.nvim'                             -- bridge between lspconfig & mason.nvim
        },
        lazy = false,
    },

    -- git
    'lewis6991/gitsigns.nvim',                                              -- Show git changes
    'tpope/vim-fugitive',                                                   -- Git wrapper
    { 'f-person/git-blame.nvim',                                            -- Git blame in Neovim
      event = 'VeryLazy' },

    -- snippets
    {'hrsh7th/vim-vsnip',                                                   -- Snippet engine (+ snippets)
        dependencies = {
            'hrsh7th/cmp-vsnip',                                            -- nvim-cmp integration
            'hrsh7th/vim-vsnip-integ',                                      -- LSP integration
            'rafamadriz/friendly-snippets',                                 -- Extra snippets
        }
    },

    -- languages
    {'pangloss/vim-javascript', ft = "javascript", },                       -- Javascript support
    {'keith/swift.vim', ft = "swift" },                                     -- Swift syntax and indent styles
    {'dag/vim-fish', ft = "fish" },                                         -- Fish script support
    {'chrisbra/csv.vim', ft = "csv" },                                      -- Browse csv files
    {'neovimhaskell/haskell-vim', ft = "haskell" },                         -- Better Haskell support
    {'posva/vim-vue', ft = "vue", },                                        -- Vue syntax
    {'leafgarland/typescript-vim', ft = "typescript" },                     -- TypeScript support
    {'peitalin/vim-jsx-typescript', ft = "typescript" },                    -- TypeScript with React support
    {'pantharshit00/vim-prisma', ft = "prisma" },                           -- Prisma 2 support
    {'jparise/vim-graphql', ft = "graphql" },                               -- GraphQL support
    {'Kranex/vim-rascal-syntax', ft = "rascal" },                           -- Rascal support
    {'cakebaker/scss-syntax.vim', ft = "scss" },                            -- SCSS support
    {'habamax/vim-rst', ft = "rst" },                                       -- RST (reStructuredText) support
    -- {'adalessa/laravel.nvim',                                               -- Laravel support
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',                                -- See 'nvim-telescope/telescope.nvim'
    --         'tpope/vim-dotenv',                                             -- Read .env file(s)
    --         'MunifTanjim/nui.nvim',                                         -- UI component library
    --         'nvimtools/none-ls.nvim',                                       -- LSP hooks
    --     },
    --     cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    --     keys = {
    --         { "<leader>la", ":Laravel artisan<cr>" },
    --         { "<leader>lr", ":Laravel routes<cr>" },
    --         { "<leader>lm", ":Laravel related<cr>" },
    --     },
    --     event = { "VeryLazy" },
    --     config = true,
    -- },

    -- nvim-cmp
    {'hrsh7th/nvim-cmp',                                                    -- Completion for Neovim
        -- event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',                                         -- nvim-cmp source for neovim builtin LSP client
            'hrsh7th/cmp-buffer',                                           -- nvim-cmp source for buffer words
            'hrsh7th/cmp-path',                                             -- nvim-cmp source for paths
            'ray-x/cmp-treesitter',                                         -- nvim-cmp source for treesitter
        }
    },

    -- Telescope
    {'nvim-telescope/telescope.nvim',                                       -- fuzzy finder over lists with popups
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim',                   -- port of fzf (recommended)
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
            'nvim-telescope/telescope-dap.nvim',                            -- nvim-dap integration with telescope
        }
    },
    { 'fdschmidt93/telescope-egrepify.nvim',                                -- live grepping with grouping by file + prefixes
        dependencies = {                                                    -- prefixes:
            'nvim-telescope/telescope.nvim',                                -- #: file suffix, >: folder names, &: file names
            'nvim-lua/plenary.nvim'
        }
    },

    -- neovim LSP plugins
    {'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-lua/lsp_extensions.nvim',                                 -- Extensions to built-in LSP, for example, providing type inlay hints
            'nvim-lua/lsp-status.nvim',                                     -- Get information about the current language server
            'jose-elias-alvarez/nvim-lsp-ts-utils',                         -- TypeScript lsp functions
            'ojroques/nvim-lspfuzzy',                                       -- Replace LSP windows with fzf ones
            'jubnzv/virtual-types.nvim',                                    -- Show type annotations
            { 'mrcjkb/rustaceanvim',                                        -- Extra Rust LSP tools (fixes inlay-hints)
            },
            'kosayoda/nvim-lightbulb'                                       -- Show lightbulb in sign column when LSP actions are available
        }
    },                                                                      -- Collection of common configs for neovim LSP client

    -- TreeSitter
    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },             -- Treesitter configurations and abstraction layer for Neovim
    { 'nvim-treesitter/nvim-treesitter-context' },                          -- Treesitter context (e.g. show function name in header)
    { 'nvim-treesitter/nvim-treesitter-textobjects' },                      -- Treesitter syntax aware text-objects

    -- Themes
    'dkasak/gruvbox',
    {'vim-airline/vim-airline-themes', lazy = true, },
    {'chriskempson/vim-tomorrow-theme', lazy = true, },
    {'flazz/vim-colorschemes', lazy = true, },
    {'altercation/vim-colors-solarized', lazy = true, },
    {'jdkanani/vim-material-theme', lazy = true, },
    {'nanotech/jellybeans.vim', lazy = true, },
    {'marcopaganini/termschool-vim-theme', lazy = true, },
    {'godlygeek/csapprox', lazy = true, },
    {'jacoborus/tender', lazy = true, },
    {'endel/vim-github-colorscheme', lazy = true, },
    {'larsbs/vimterial', lazy = true, },
    {'bcicen/vim-vice', lazy = true, },
    {'dylanaraps/wal.vim', lazy = true, },
    {'chriskempson/base16-vim', lazy = true, },
}

local opts = {
    ui = {
        border = "single",
    },
}

require("lazy").setup(plugins, opts)
