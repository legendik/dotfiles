return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "golangci-lint",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft.go = { "golangcilint" }

      local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
