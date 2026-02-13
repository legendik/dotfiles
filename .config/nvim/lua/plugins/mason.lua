return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- lua
        "stylua",

        -- shell
        "shellcheck",
        "shfmt",

        -- go
        "goimports",
        "gopls",
        "golangci-lint",

        -- js/ts
        "eslint_d",
        "prettierd",

        -- php
        "intelephense",
      })
    end,
  },
}
