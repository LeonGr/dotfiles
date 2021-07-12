-- Lua settings

-- lewis6991/gitsigns.nvim
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '┇', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
}

-- nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        --disable = { "c", "rust" },  -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}

-- sindrets/diffview.nvim
require'diffview'.setup {
    file_panel = {
        use_icons = false
    }
}

-- TimUntersberger/neogit
require'neogit'.setup {
    integrations = {
        diffview = true
    }
}

-- aserowy/tmux.nvim
require'tmux'.setup {
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = false,
        -- TMUX >= 3.2: yanks (and deletes) will get redirected to system
        -- clipboard by tmux
        redirect_to_clipboard = true,
    },
    navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
    }
}

-- vhyrro/neorg
-- require'neorg'.setup {
    -- -- Tell Neorg what modules to load
    -- load = {
        -- ["core.defaults"] = {}, -- Load all the default modules
        -- ["core.norg.concealer"] = {}, -- Allows for use of icons
        -- ["core.norg.dirman"] = { -- Manage your directories with Neorg
            -- config = {
                -- workspaces = {
                    -- my_workspace = "~/neorg"
                -- }
            -- }
        -- }
    -- },
-- }
