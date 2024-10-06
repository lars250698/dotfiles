return {
  { "nvim-neotest/nvim-nio" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },

    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.25,
              },
              {
                id = "breakpoints",
                size = 0.25,
              },
              {
                id = "stacks",
                size = 0.25,
              },
              {
                id = "watches",
                size = 0.25,
              },
            },
            position = "right",
            size = 100,
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.7,
              },
              {
                id = "console",
                size = 0.3,
              },
            },
            position = "bottom",
            size = 20,
          },
        },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ width = 80 })
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Configure the JavaScript/TypeScript adapter
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/go-debug-adapter",
          args = { "-port", "${port}" },
        },
      }

      -- Configuration for debugging Node.js/TypeScript applications
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug NestJS app",
          args = { "${workspaceFolder}/src/main.ts" },
          runtimeArgs = {
            "--nolazy",
            "-r",
            "ts-node/register",
            "-r",
            "tsconfig-paths/register",
          },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          port = 9229,
          protocol = "inspector",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
      }

      -- Use the same configuration for JavaScript
      dap.configurations.javascript = dap.configurations.typescript

      -- Configurations for debugging Golang
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug (Build Flags)",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug (Build Flags & Arguments)",
          request = "launch",
          program = "${file}",
        },
      }
    end,
  },
}
