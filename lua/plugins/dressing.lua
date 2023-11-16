-- Better vim.ui.{select,prompt}
return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      default_prompt = "❯ ",
      mappings = {
        i = {
          ["<C-P>"] = "HistoryPrev",
          ["<C-N>"] = "HistoryNext",
        },
      },
    },
    select = {
      backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },
      mappings = {
        i = {
          ["<C-P>"] = "HistoryPrev",
          ["<C-N>"] = "HistoryNext",
        },
      },
    },
  },
}
