return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      vim.keymap.set('n', '<leader>H', function()
        harpoon:list():add()
      end, { desc = 'Harpoon current buffer' })
      vim.keymap.set('n', '<leader>h', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open harpoon' })
      for i = 1, 5 do
        vim.keymap.set('n', '<leader>' .. i, function()
          harpoon:list():select(i)
        end, { desc = 'Switch to harpooned buffer ' .. i })
      end
    end,
  },
}
