------ Lua settings

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

-- add border to hover
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single"
  }
)

-- add border to signature
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single"
  }
)

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
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        enable = false, -- MANUALLY disable setting vim.g.clipboard in tmux.nvim/lua/tmux/copy.lua
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
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, '\n')
end

-- search for the current selection
vim.keymap.set('v', '<Leader>R', function()
    local text = get_visual_selection()
    require('telescope.builtin').grep_string({ search = text })
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
        highlight = {colors.wal_blue, colors.wal_blue},
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "  "
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
            return "  " .. dir_name .. " "
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
            return " "
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
    ShortLinestatusIcon = {
        provider = function()
            return " ⏾ "
        end,
        highlight = {colors.wal_blue, colors.bg},
        separator = " ",
        separator_highlight = {colors.bg, colors.wal_blue},
        condition = condition.not_dap_ui,
    }
}

gls.short_line_left[3] = {
    ShortLinecurrent_dir = {
        provider = function()
            -- :p = full path
            -- :~ = relative to ~ if possible
            local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ":p:~")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.bg, colors.wal_blue},
        separator = " ",
        separator_highlight = {colors.wal_blue, colors.bg},
        condition = condition.not_dap_ui,
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
