return {
  -- {
  --   'sphamba/smear-cursor.nvim',
  --   opts = {
  --     smear_insert_mode = false,
  --     smear_between_buffers = false,
  --     smear_to_cmd = false,
  --   },
  -- },
  {
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup {
        flavour = 'macchiato',
        integrations = {
          mini = {
            enabled = true,
          },
          cmp = true,
          gitsigns = true,
          notify = true,
          flash = true,
          indent_blankline = {
            enabled = true,
            scope_color = 'lavender',
            colored_indent_levels = true,
          },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
          noice = true,
          snacks = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
          blink_cmp = {
            style = 'bordered',
          },
          harpoon = true,
          markview = true,
          nvim_surround = true,
          rainbow_delimiters = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      local colors = require('catppuccin.palettes').get_palette 'macchiato'
      local O = require('catppuccin').options
      local transparent_bg = O.transparent_background and 'NONE' or colors.mantle
      local icons = {
        git = {
          added = ' ',
          modified = ' ',
          removed = ' ',
        },
      }

      vim.o.laststatus = vim.g.lualine_laststatus

      local theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.mantle, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.blue },
          c = { bg = transparent_bg, fg = colors.text },
        },
        insert = {
          a = { bg = colors.mauve, fg = colors.base, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.mauve },
        },
        visual = {
          a = { bg = colors.green, fg = colors.base, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.green },
        },
        replace = {
          a = { bg = colors.red, fg = colors.base, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.red },
        },
        command = {
          a = { bg = colors.rosewater, fg = colors.base, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.rosewater },
        },
        inactive = {
          a = { bg = transparent_bg, fg = colors.blue },
          b = { bg = transparent_bg, fg = colors.surface1, gui = 'bold' },
          c = { bg = transparent_bg, fg = colors.overlay0 },
        },
        terminal = {
          a = { bg = colors.green, fg = colors.base, gui = 'bold' },
          b = { bg = colors.surface0, fg = colors.green },
        },
      }

      local time = function()
        return ' ' .. os.date '%R'
      end

      local mode = {
        'mode',
        separator = { left = '', right = '' },
        right_padding = 2,
      }

      local diff = {
        'diff',
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

      local filetype = {
        'filetype',
        icon_only = true,
        separator = '',
        padding = {
          left = 2,
          right = 0,
        },
      }

      local filename = {
        'filename',
        file_status = true,
        path = 1,
        newfile_status = true,
        shorting_target = 50,
        symbols = {
          modified = '[+]', -- Text to show when the file is modified.
          readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]', -- Text to show for newly created file before first write
        },
      }

      local noice_status = {
        function()
          return require('noice').api.status.command.get()
        end,
        cond = function()
          return package.loaded['noice'] and require('noice').api.status.command.has()
        end,
        color = function()
          return { fg = Snacks.util.color 'Statement' }
        end,
      }

      local noice_mode = {
        function()
          return require('noice').api.status.mode.get()
        end,
        cond = function()
          return package.loaded['noice'] and require('noice').api.status.mode.has()
        end,
        color = function()
          return { fg = Snacks.util.color 'Constant' }
        end,
      }

      -- local neotree = {
      --   filetypes = { 'neo-tree' },
      --   sections = {
      --     lualine_a = {
      --       {
      --         function()
      --           return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
      --         end,
      --         separator = { left = '', right = '' },
      --       },
      --     },
      --     lualine_b = { 'branch' },
      --     lualine_c = {},
      --     lualine_x = {},
      --     lualine_y = {},
      --     lualine_z = { time },
      --   },
      -- }

      return {
        options = {
          theme = theme,
          component_separators = '',
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { 'branch' },
          lualine_c = {
            filetype,
            filename,
          },
          lualine_x = {
            Snacks.profiler.status(),
            noice_status,
            noice_mode,
            diff,
          },
          lualine_y = {
            { 'trouble', separator = ' ', padding = { left = 1, right = 0 } },
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = { time },
        },
        extensions = {
          'trouble',
          'lazy',
          -- neotree,
        },
      }
    end,
  },
}
