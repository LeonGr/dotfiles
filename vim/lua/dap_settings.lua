local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint' })
vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#993939' }, false)
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', numhl='DapStopped' })
vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379' }, false)

-- Use LLDB
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = '/usr/bin/codelldb',
        args = {"--port", "${port}"},

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
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


-- use debugpy
dap.adapters.python = {
    type = 'executable';
    command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python";
    args = { '-m', 'debugpy.adapter' };
}

-- enable for python
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
