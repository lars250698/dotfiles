return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        win_options = {
          signcolumn = 'yes:2',
        },
        view_options = {
          show_hidden = true,
        },
        watch_for_changes = true,
      }

      vim.keymap.set('n', '-', '<Cmd>Oil<CR>')
      vim.keymap.set('n', '_', '<Cmd>Oil .<CR>')
    end,
  },
  {
    'refractalize/oil-git-status.nvim',

    dependencies = {
      'stevearc/oil.nvim',
    },

    config = true,
  },
}
