-- Better vim.ui.{select,input}
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
      mappings = {
        i = {
          ["<C-P>"] = "HistoryPrev",
          ["<C-N>"] = "HistoryNext",
        },
      },
    },
  },
}
