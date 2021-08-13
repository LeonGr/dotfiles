------ Lua settings

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
    autopairs = {
        enable = true,
    },
}

---- sindrets/diffview.nvim
require'diffview'.setup {
    file_panel = {
        use_icons = false
    }
}

---- TimUntersberger/neogit
require'neogit'.setup {
    integrations = {
        diffview = true
    }
}

---- aserowy/tmux.nvim
require'tmux'.setup {
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = true, -- MANUALLY disable setting vim.g.clipboard in tmux.nvim/lua/tmux/copy.lua
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

---- vhyrro/neorg
require'neorg'.setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/neorg"
                }
            }
        }
    },
}

---- hrsh7th/nvim-compe
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 2;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = {
        border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
    };

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
        ultisnips = true;
        luasnip = false;
        treesitter = true;
    };
}

-- map Tab and S-Tab to complete jumps
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn['vsnip#available'](1) == 1 then
    -- return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  -- else
    -- return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  -- elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    -- return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

---- windwp/nvim-autopairs
require'nvim-autopairs'.setup({
    check_ts = true,
})

require("nvim-autopairs.completion.compe").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true -- it will auto insert `(` after select function or method item
})

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
            }
        },
        layout_config = {
            horizontal = {
                prompt_position = "top"
            }
        },
        sorting_strategy = "ascending"
    },
    extensions = {
        fzf = {

        }
    }
}

require'telescope'.load_extension('fzf')


---- glepnir/galaxyline.nvim

-- config adapted from https://github.com/siduck76/NvChad/blob/main/lua/plugins/statusline.lua
local gl = require'galaxyline'
local condition = require'galaxyline.condition'

local gls = gl.section

gl.short_line_list = {" "}

local colors = require('galaxyline.theme').default
local colorjson = vim.fn.readfile(vim.fn.expand("~/.cache/wal/colors.json"))
local wal_colors = vim.fn.json_decode(colorjson)
colors.white = wal_colors.special.foreground
colors.fg = wal_colors.special.foreground
colors.wal_blue = wal_colors.colors.color2

vim.cmd("highlight StatusLine guibg=" .. colors.bg)
vim.cmd("highlight StatusLine guifg=" .. colors.fg)
vim.cmd("highlight StatusLineNC guibg=" .. colors.wal_blue)

gls.left[1] = {
    FirstElement = {
        provider = function()
            return "▋"
        end,
        highlight = {colors.wal_blue, colors.wal_blue}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "  "
        end,
        highlight = {colors.bg, colors.wal_blue},
        separator = " ",
        separator_highlight = {colors.wal_blue, colors.bg}
    }
}

gls.left[3] = {
    current_dir = {
        provider = function()
            -- :p = full path
            -- :~ = relative to ~ if possible
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:~")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.white, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.wal_blue}
    }
}

gls.left[4] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.bg, colors.wal_blue}
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

-- local checkwidth = function()
    -- local squeeze_width = vim.fn.winwidth(0) / 2
    -- if squeeze_width > 30 then
        -- return true
    -- end
    -- return false
-- end

-- gls.left[6] = {
    -- DiffAdd = {
        -- provider = "DiffAdd",
        -- condition = checkwidth,
        -- icon = "  ",
        -- highlight = {colors.white, colors.bg}
    -- }
-- }

-- gls.left[6] = {
    -- DiffModified = {
        -- provider = "DiffModified",
        -- condition = checkwidth,
        -- icon = "   ",
        -- highlight = {colors.fg, colors.bg}
    -- }
-- }

-- gls.left[7] = {
    -- DiffRemove = {
        -- provider = "DiffRemove",
        -- condition = checkwidth,
        -- icon = "  ",
        -- highlight = {colors.fg, colors.bg}
    -- }
-- }

gls.left[6] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[7] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
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
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.fg, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.condition").check_git_workspace,
        highlight = {colors.fg, colors.bg}
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
        highlight = {colors.bg, colors.green}
    }
}

gls.right[7] = {
    line_percentage = {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            -- if current_line == 1 then
                -- return "  Top "
            -- elseif current_line == vim.fn.line("$") then
                -- return "  Bot "
            -- end
            local result, _ = math.modf((current_line / total_line) * 100)
            return "  " .. result .. "% "
        end,
        highlight = {colors.green, colors.bg}
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
    ShortLinestatusIcon = {
        provider = function()
            return " ⏾ "
        end,
        highlight = {colors.wal_blue, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.wal_blue}
    }
}

gls.short_line_left[3] = {
    ShortLinecurrent_dir = {
        provider = function()
            -- :p = full path
            -- :~ = relative to ~ if possible
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:~")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.bg, colors.wal_blue},
        separator = " ",
        separator_highlight = {colors.wal_blue, colors.bg}
    }
}

gls.short_line_left[4] = {
    ShortLineFileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {colors.wal_blue, colors.bg}
    }
}

gls.short_line_left[5] = {
    ShortLineFileName = {
        provider = {"FileName"},
        condition = condition.buffer_not_empty,
        highlight = {colors.wal_blue, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.wal_blue}
    }
}
