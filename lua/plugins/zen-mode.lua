return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
        },
      },
      on_open = function(win)
        -- Override the backdrop color and make it transparent
        -- The backdrop color is not working well with my guibg=none color
        vim.cmd(("highlight ZenBg guibg=%s guifg=%s"):format("none", "none"))

        vim.wo[win].wrap = true
      end,
    })

    vim.keymap.set("n", "<C-W><C-G>", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
    vim.keymap.set("n", "<C-W>g", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
    vim.keymap.set("n", "<leader>G", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
  end,
}
