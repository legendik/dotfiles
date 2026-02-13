return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = {
          cmd = { "golangci-lint-langserver" },
          init_options = {
            command = { "golangci-lint", "run", "--output.json.path", "stdout", "--show-stats=false" },
          },
        },
        gopls = {
          settings = {
            gopls = {
              staticcheck = true,
              analyses = {
                ST1000 = false,
                ST1001 = false,
              },
            },
          },
        },
      },
    },
  },
}
