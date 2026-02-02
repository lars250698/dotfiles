return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.trailspace').setup()
      require('mini.cursorword').setup()
      require('mini.splitjoin').setup()
      require('mini.move').setup {
        mappings = {
          left = '<S-left>',
          right = '<S-right>',
          down = '<S-down>',
          up = '<S-up>',

          line_left = '<S-left>',
          line_right = '<S-right>',
          line_down = '<S-down>',
          line_up = '<S-up>',
        },

        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
}
