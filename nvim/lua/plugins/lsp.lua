return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          enabled = false,
        },
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
          },
        },
      },
    },
  },
}
