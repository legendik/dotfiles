return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true, -- Show files in .gitignore
          },
        },
      },
    },
  },
}
