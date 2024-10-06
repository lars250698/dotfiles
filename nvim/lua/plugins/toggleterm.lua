return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      { "<leader>t", "", desc = "terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=30<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=90<cr>", desc = "Toggle vertical terminal" },
    },
    opts = {
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },
}
