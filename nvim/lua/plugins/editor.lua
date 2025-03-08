return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter", -- load only when entering command-line mode
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<Up>"] = cmp.mapping.select_prev_item(), -- arrow up to select previous item
          ["<Down>"] = cmp.mapping.select_next_item(), -- arrow down to select next item
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "cmdline" },
        },
      })
    end,
  },
}
