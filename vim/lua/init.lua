------ Lua settings

-- install lazy.nvim (plugin management)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
    {'cakebaker/scss-syntax.vim',                                           -- SCSS support
        ft = "scss"
    },
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
    'stevearc/dressing.nvim',                                               -- Allow overriding UI hooks (used for RustRunnables w/ Telescope)
    { 'mistricky/codesnap.nvim', build = "make build_generator" },          -- Take pretty screenshots of code

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
    {'mfussenegger/nvim-jdtls',                                             -- Debug Adapter Protocol (DAP) client implementation
        ft = { "java" },
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
            { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }, -- port of fzf
            'nvim-telescope/telescope-dap.nvim',                            -- nvim-dap integration with telescope
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
            'simrat39/rust-tools.nvim',                                     -- Extra Rust LSP tools (fixes inlay-hints)
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

-- set colors
local colors = require('galaxyline.theme').default

-- helper functions to determine if file exists
local function expand_tilde(path)
  if path:sub(1, 1) == '~' then -- Check if path starts with tilde
    local home = os.getenv('HOME') or os.getenv('USERPROFILE')
    return home .. path:sub(2) -- Replace tilde with home directory path
  else
    return path
  end
end

local function file_exists(path)
  path = expand_tilde(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'file'
end

if file_exists("~/.cache/wal/colors.json") then
    local colorjson = vim.fn.readfile(vim.fn.expand("~/.cache/wal/colors.json"))
    local wal_colors = vim.fn.json_decode(colorjson)
    colors.white = wal_colors.special.foreground
    colors.fg = wal_colors.special.foreground
    colors.bg = wal_colors.special.background
    colors.wal_blue = wal_colors.colors.color2
else
    colors.wal_blue = colors.blue
end

-- configure mason
require("mason").setup({
    ui = {
        border = "single",
    }
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer" },
})

---- lewis6991/gitsigns.nvim
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '┇', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
}

---- nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "markdown", "gitcommit" },   -- list of language that will be disabled
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
    autopairs = {
        enable = true,
    },
}

---- aserowy/tmux.nvim
require'tmux'.setup {
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = false,
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

---- hrsh7th/nvim-cmp
local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'treesitter' },
    },
    window = {
        documentation = {
            border = { ' ', ' ' ,' ', ' ', ' ', ' ', ' ', ' ' },
            winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
        };
    }
}

---- windwp/nvim-autopairs
require'nvim-autopairs'.setup({
    check_ts = true,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

---- norcalli/nvim-colorizer.lua
require'colorizer'.setup( nil, {
    RGB      = true;        -- #RGB hex codes
    RRGGBB   = true;        -- #RRGGBB hex codes
    names    = true;        -- "Name" codes like Blue
    RRGGBBAA = true;        -- #RRGGBBAA hex codes
    rgb_fn   = true;        -- CSS rgb() and rgba() functions
    hsl_fn   = true;        -- CSS hsl() and hsla() functions
    css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

---- ojroques/nvim-lspfuzzy
require'lspfuzzy'.setup {}

---- nvim-telescope/telescope.nvim
require'telescope'.setup {
    defaults = {
        prompt_prefix = "λ ",
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
            }
        },
        layout_config = {
            horizontal = {
                prompt_position = "top"
            }
        },
        sorting_strategy = "ascending"
    },
}

require'telescope'.load_extension('fzf')
require'telescope'.load_extension('dap')

local function get_visual_selection()
    local s_start = vim.fn.getpos("v")
    local s_end = vim.fn.getpos(".")

    local n_lines = math.abs(s_end[2] - s_start[2]) + 1

    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)

    -- check if start and end positions are different, if not, we just send the selected lines.
    -- this breaks on VISUAL LINE with multiple lines, but oh well
    if not (s_start[2] == s_end[2] and s_start[3] == s_end[3]) then
        lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
        lines[1] = string.sub(lines[1], s_start[3], -1)

        if n_lines == 1 then
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
        else
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
        end
    end

    return table.concat(lines, '\n')
end

-- search for the current selection (globally)
vim.keymap.set('v', '<Leader>R', function()
    local text = get_visual_selection()
    print("search current selection - selected text:", text)
    require('telescope.builtin').grep_string({ default_text = text })
end, { expr = false })

-- search for the current selection (current file)
vim.keymap.set('v', '<Leader>F', function()
    local text = get_visual_selection()
    print("search current selection - selected text:", text)
    require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })
end, { expr = false })

---- glepnir/galaxyline.nvim

-- config adapted from https://github.com/siduck76/NvChad/blob/main/lua/plugins/statusline.lua
local gl = require'galaxyline'
local condition = require'galaxyline.condition'

condition.not_dap_ui = function()
    return vim.o.filetype:find("dap") == nil
end

local gls = gl.section

gl.short_line_list = {" "}

vim.cmd("highlight StatusLine guibg=" .. colors.bg)
vim.cmd("highlight StatusLine guifg=" .. colors.fg)
vim.cmd("highlight StatusLineNC guibg=" .. colors.bg)

gls.left[1] = {
    FirstElement = {
        provider = function()
            return "▋"
        end,
        highlight = {colors.wal_blue, colors.wal_blue},
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return " 󰀘 "
        end,
        highlight = {colors.bg, colors.wal_blue},
        separator = " ",
        separator_highlight = {colors.wal_blue, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.left[3] = {
    current_dir = {
        provider = function()
            -- :p = full path
            -- :~ = relative to ~ if possible
            -- local working_dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:~")
            local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ":p:~")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.white, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.wal_blue},
        condition = condition.not_dap_ui,
    }
}

gls.left[4] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.bg, colors.wal_blue},
    }
}

gls.left[5] = {
    FileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.bg, colors.wal_blue},
        separator = " ",
        separator_highlight = {colors.wal_blue, colors.bg}
    }
}

gls.left[6] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.left[7] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.right[1] = {
    lsp_status = {
        provider = function()
            local clients = vim.lsp.get_active_clients()
            if next(clients) ~= nil then
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return " " .. "  " .. client.name
                    end
                end
                return ""
            else
                return ""
            end
        end,
        highlight = {colors.fg, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = condition.check_git_workspace and condition.not_dap_ui,
        highlight = {colors.fg, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace and condition.not_dap_ui,
        highlight = {colors.fg, colors.bg},
    }
}

gls.right[4] = {
    viMode_icon = {
        provider = function()
            return " "
        end,
        separator = " ",
        highlight = 'GalaxyViModeInvert',
        separator_highlight = 'GalaxyViMode'
    }
}

gls.right[5] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual Line",
                [""] = "Visual Block",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            local mode_color = {
                -- see :help mode()
                n = colors.red, i = colors.blue, v = colors.orange,
                [''] = colors.orange,V=colors.orange,
                c = colors.magenta,no = colors.red,s = colors.orange,
                S=colors.orange,[''] = colors.orange,
                ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                cv = colors.red,ce=colors.red, r = colors.cyan,
                rm = colors.cyan, ['r?'] = colors.cyan,
                ['!']  = colors.red,t = colors.cyan
            }

            vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()]..' guibg='..colors.bg)
            vim.api.nvim_command('hi GalaxyViModeInvert guibg='..mode_color[vim.fn.mode()]..' guifg='..colors.bg)

            if current_Mode == nil then
                return "  Terminal "
            else
                return "  " .. current_Mode .. " "
            end
        end,
        highlight = {colors.red, colors.bg}
    }
}

gls.right[6] = {
    some_icon = {
        provider = function()
            return " "
        end,
        separator = "",
        separator_highlight = {colors.green, colors.bg},
        highlight = {colors.bg, colors.green},
        condition = condition.not_dap_ui,
    }
}

gls.right[7] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local current_col = vim.fn.col(".")
            local total_line = vim.fn.line("$")

            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. current_line .. "," .. current_col .. "  " .. result .. "% "
        end,
        highlight = {colors.green, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.short_line_left[1] = {
    ShortLineFirstElement = {
        provider = function()
            return "▋"
        end,
        highlight = {colors.bg, colors.bg}
    }
}

gls.short_line_left[2] = {
    ShortLinecurrent_dir = {
        provider = function()
            -- :p = full path
            -- :~ = relative to ~ if possible
            local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ":p:~")
            return dir_name
        end,
        highlight = {colors.wal_blue, colors.bg},
        condition = condition.not_dap_ui,
    }
}

gls.short_line_left[3] = {
    ShortLineFileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.wal_blue, colors.bg},
    }
}

---- akinsho/bufferline.nvim
local bufferline = require("bufferline")
bufferline.setup{
    options = {
        style_preset = bufferline.style_preset.no_italic,
        -- diagnostics = "nvim_lsp",
        -- diagnostics_indicator = function(count, level, _, _)
            -- local icon = level:match("error") and " " or " "
            -- return " " .. icon .. count
        -- end,
        diagnostics = false,
        separator_style = "none",
        indicator = {
            style = "icon",
        },
        numbers = function(opt)
            return string.format('%s', opt.raise(opt.ordinal))
        end,
    },
    highlights = {
        buffer_selected = {
            italic = false,
        },
        numbers_selected = {
            italic = false,
        },
        indicator_selected = {
            fg = colors.wal_blue,
        }
    }
}

local function go_to_buffer(ordinal_buffer_nr)
    -- open buffer with given nr.
    -- 'true' means that absolute buffer nr should be used
    bufferline.go_to(ordinal_buffer_nr, true)
end

vim.api.nvim_create_user_command(
    'BB',
    function(opts)
        -- print(opts)
        go_to_buffer(opts.args)
    end,
    { nargs = 1}
)

for i = 1,9 do
    vim.keymap.set('n', '<leader>' .. i, function() go_to_buffer(i) end, {})
end

---- gelguy/wilder.nvim

local wilder = require('wilder')

-- Enable for search (/,? and commands :)
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            fuzzy = 1,
        }),
        wilder.python_search_pipeline({
            -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
            pattern = wilder.python_fuzzy_pattern(),
        })
    ),
})

wilder.set_option('renderer', wilder.wildmenu_renderer({
    highlighter = {
        wilder.basic_highlighter(),
    },
    right = {' ', wilder.wildmenu_index()},
    highlights = {
        default = "Normal",
        accent = wilder.make_hl(
            'WilderAccent',
            'Normal',
            {
                {a = 1}, {a = 1}, { foreground = colors.wal_blue }
            }
        ),
        selected = wilder.make_hl(
            'WilderSelected',
            'Normal',
            {
                {a = 1}, {a = 1}, { reverse = 1 }
            }
        ),
        -- selected_accent = wilder.make_hl(
            -- 'WilderSelectedAccent',
            -- 'Normal',
            -- {
                -- {a = 1}, {a = 1}, { reverse = 1, background = colors.red }
            -- }
        -- ),
    },
}))

---- mistricky/codesnap.nvim
require("codesnap").setup()
