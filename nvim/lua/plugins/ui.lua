return {
  {
    "catppuccin/nvim",
    opts = {
      flavor = "macchiato",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local colors = require("catppuccin.palettes").get_palette("macchiato")
      local O = require("catppuccin").options
      local transparent_bg = O.transparent_background and "NONE" or colors.mantle
      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.mantle, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.blue },
          c = { bg = transparent_bg, fg = colors.text },
        },
        insert = {
          a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.mauve },
        },
        visual = {
          a = { bg = colors.green, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.green },
        },
        replace = {
          a = { bg = colors.red, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.red },
        },
        command = {
          a = { bg = colors.rosewater, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.rosewater },
        },
        inactive = {
          a = { bg = transparent_bg, fg = colors.blue },
          b = { bg = transparent_bg, fg = colors.surface1, gui = "bold" },
          c = { bg = transparent_bg, fg = colors.overlay0 },
        },
        terminal = {
          a = { bg = colors.green, fg = colors.base, gui = "bold" },
          b = { bg = colors.surface0, fg = colors.green },
        },
      }

      local neotree = {
        -- This extension will only be active for neo-tree buffers.
        filetypes = { "neo-tree" },
        sections = {
          -- Customize the section components and their separators as desired.
          lualine_a = {
            {
              function()
                return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
              end,
              separator = { left = "", right = "" },
            },
          },
          lualine_b = { "branch" },
          lualine_c = {},
          -- You can define additional sections if needed.
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
      }

      local mode = {
        "mode",
        separator = { left = "", right = "" },
        right_padding = 2,
      }

      local noice_status = {
        function()
          return require("noice").api.status.command.get()
        end,
        cond = function()
          return package.loaded["noice"] and require("noice").api.status.command.has()
        end,
        color = function()
          return { fg = Snacks.util.color("Statement") }
        end,
      }

      local noice_mode = {
        function()
          return require("noice").api.status.mode.get()
        end,
        cond = function()
          return package.loaded["noice"] and require("noice").api.status.mode.has()
        end,
        color = function()
          return { fg = Snacks.util.color("Constant") }
        end,
      }

      local diff = {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      }

      return {
        options = {
          theme = theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch" },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
            noice_status,
            noice_mode,
            diff,
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = {
          "lazy",
          neotree,
        },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      zen = {
        transparent = false,
        width = 1,
        height = 1,
        -- your zen configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
  },
}
