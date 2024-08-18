-- Show you pending keybinds.
return {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    win = {
      wo = {
        winblend = 10,
      },
    },
  },
}
