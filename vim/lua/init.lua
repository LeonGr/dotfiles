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

require('plugins')

-- set colors
local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef';
    red = '#ec5f67';
    darkgrey = '#424242';
}

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
        add          = { text = '┃' },
        change       = { text = '┇' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
    },
}

---- nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "markdown", "gitcommit" },   -- list of language that will be disabled
        disable = { "gitcommit" },   -- list of languages that will be disabled
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

-- configure blade files parser (PHP/Laravel)
-- See also: https://seankegel.com/neovim-for-php-and-laravel (for extra config needed)
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade",
}

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

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

---- nvim-lualine/lualine.nvim

require('lualine').setup({
    sections = {
        lualine_c = {
            {
                'filename',
                path = 3, -- show absolute path, using ~ for $HOME
            }
        },
        -- default version doesn't show LSP, so add it:
        lualine_x = {
            'encoding',
            'fileformat',
            {
                'lsp_status',
                icon = '', -- don't show icon, just the LSP server name
                symbols = {
                    done = '', -- don't show checkmark when loading is done (still shows loading spinner)
                },
            },
            'filetype'
        }
    },
    extensions = { 'nvim-dap-ui' },
})

---- akinsho/bufferline.nvim
local bufferline = require("bufferline")
bufferline.setup{
    options = {
        style_preset = bufferline.style_preset.no_italic,
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

-- popup menu floating in the middle of the screen
wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
        -- Remove the border (8 characters), since `vim.o.winborder` already adds one:
        border = { '', '', '', '', '', '', '', '' },
        -- Set a border for the prompt manually. Needed because we didn't choose a standard border option above.
        prompt_border = { '─', '─', '─' },
        max_height = '75%',      -- max height of the palette
        min_height = 0,          -- set to the same as 'max_height' for a fixed height window
        prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
    })
))

---- mistricky/codesnap.nvim
require("codesnap").setup()


---- kosayoda/nvim-lightbulb
require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

---- nvim-tree/nvim-tree.lua
require("nvim-tree").setup()

---- echasnovski/mini.ai
require('mini.ai').setup()
