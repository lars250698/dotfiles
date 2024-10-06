return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              format = {
                enable = false,
              },
            },
            javascript = {
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<M-CR>",
        function()
          vim.lsp.buf.code_action({ apply = true })
        end,
        desc = "Code action",
      },
      {
        "<D-M-l>",
        function()
          vim.lsp.buf.format()
        end,
        desc = "Format",
      },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
      })
    end,
  },
  {
    "LukasPietzschmann/boo.nvim",
    keys = {
      vim.keymap.set("n", "<leader>cb", function()
        require("boo").boo()
      end, { desc = "Boo Preview" }),
    },
  },
}
