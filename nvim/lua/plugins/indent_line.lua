return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    -- opts = {},
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }
      local hooks = require 'ibl.hooks'
      local colors = require('catppuccin.palettes').get_palette 'macchiato'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = colors.red })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = colors.yellow })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = colors.blue })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = colors.peach })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = colors.green })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = colors.mauve })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = colors.teal })
      end)

      require('rainbow-delimiters.setup').setup { highlight = highlight }
      require('ibl').setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
