return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      scroll = {
        animate = {
          duration = { step = 15, total = 250 },
          easing = 'linear',
        },
        -- faster animation when repeating scroll after delay
        animate_repeat = {
          delay = 100, -- delay in ms before using the repeat animation
          duration = { step = 5, total = 50 },
          easing = 'linear',
        },
        -- what buffers to animate
        filter = function(buf)
          return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            },
          },
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
    },
    keys = {
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bo',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Delete all Buffers except Current',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = '[/] Grep',
      },
      {
        '<leader><space>',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Find Buffers',
      },
      {
        '<leader>fq',
        function()
          Snacks.picker.quickfix()
        end,
        desc = 'Quickfix list',
      },
      {
        '<leader>fd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics list',
      },
      {
        '<leader>fs',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search history',
      },
      {
        '<leader>ft',
        function()
          Snacks.picker.treesitter()
        end,
        desc = 'Treesitter',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
    },
  },
}
