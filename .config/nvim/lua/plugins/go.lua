return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = {
          settings = {
            golangci_lint_ls = {
              cmd = { "golangci-lint-langserver" },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              staticcheck = {
                -- Disable ST1000 (wrong case in package name) and ST1001 (dot imports)
                -- since you're using golangci-lint for these checks
                checks = { "ST1000", "ST1001" },
              },
            },
          },
        },
      },
    },
  },
}