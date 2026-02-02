-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>bp',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle [B]reak[p]oint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    local signs = {
      DapBreakpoint = { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
      DapBreakpointCondition = { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' },
      DapLogPoint = { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' },
      DapStopped = { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' },
      DapBreakpointRejected = { text = '󰏤', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' },
    }

    for name, config in pairs(signs) do
      vim.fn.sign_define(name, config)
    end
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e06c75' }) -- Red
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#98c379' }) -- Green
    vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#61afef', bold = true }) -- Blue
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2c313c' }) -- Grey background for the current line

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Configure the JavaScript/TypeScript adapter
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          require('mason-registry').get_package('js-debug-adapter'):get_install_path() .. '/js-debug/src/dapDebugServer.js',
          '${port}',
        },
      },
    }

    dap.adapters['go'] = {
      type = 'server',
      port = '${port}',
      executable = {
        command = '/Users/lars.eppinger/go/bin/dlv',
        args = { 'dap', '-l', '127.0.0.1:' .. '${port}' },
        detached = vim.fn.has 'win32' == 0,
        cwd = nil,
      },
      options = {
        initialize_timeout_sec = 20,
      },
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug Project Entry Point',
        request = 'launch',
        program = function()
          -- Search for any .go file containing 'package main'
          -- This uses the shell 'grep' which is fast on Linux/Mac
          local handle = io.popen "rg -l 'package main' **/*.go | head -n 1"
          local result = handle:read '*a'
          handle:close()

          if result ~= '' then
            -- Return the directory containing that file
            return vim.fn.fnamemodify(result:gsub('%s+', ''), ':p:h')
          end

          -- Fallback: ask the user if grep fails
          return vim.fn.input('Path to entry package: ', vim.fn.getcwd() .. '/', 'dir')
        end,
      },
      {
        type = 'go',
        name = 'Debug test',
        request = 'launch',
        mode = 'test',
        program = '${fileDirname}',
      },
      {
        type = 'go',
        name = 'Debug test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
      },
    }

    -- Configuration for debugging Node.js/TypeScript applications
    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Debug NestJS app',
        args = { '${workspaceFolder}/src/main.ts' },
        runtimeArgs = {
          '--nolazy',
          '-r',
          'ts-node/register',
          '-r',
          'tsconfig-paths/register',
        },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        port = 9229,
        protocol = 'inspector',
      },
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Debug Jest Tests',
        runtimeExecutable = 'node',
        runtimeArgs = {
          './node_modules/jest/bin/jest.js',
          '--runInBand',
        },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
      },
    }

    -- Use the same configuration for JavaScript
    dap.configurations.javascript = dap.configurations.typescript
  end,
}
