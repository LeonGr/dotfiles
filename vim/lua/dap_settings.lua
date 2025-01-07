local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', numhl='DapBreakpoint' })
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#993939' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', numhl='DapStopped' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#98c379' })

vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { ctermbg=0, fg='#FFFFFF', italic=true })

-- Use codeLLDB
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = 'codelldb',
        args = {"--port", "${port}"},

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}

dap.configurations.cpp = {
    {
        name = "Launch lldb",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        terminal = "integrated",
    },
}

-- Set default external terminal
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/kitty';
    args = {'-e'}; -- flag executes command on start
}

-- enable for C
dap.configurations.c = dap.configurations.cpp

-- enable for Rust
dap.configurations.rust = dap.configurations.cpp

-- enable for python
require("dap-python").setup("python")

-- enable for php
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '~/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000
  }
}

-- nvim-dap-ui
require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})

-- nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup({
    show_stop_reason = true,
})
