return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

          keymaps = {
            -- TODO: Figure out good keys for these
            ["atf"] = { query = "@function.outer", desc = "Function" },
            ["itf"] = { query = "@function.inner", desc = "Function body" },
            ["atp"] = { query = "@parameter.outer", desc = "Outer parameter" },
            ["itp"] = { query = "@parameter.inner", desc = "Inner parameter" },
            ["atc"] = { query = "@call.outer", desc = "Outer function call" },
            ["itc"] = { query = "@call.inner", desc = "Inner function call" },
            ["ato"] = { query = "@comment.outer", desc = "Outer comment" },
            ["ito"] = { query = "@comment.inner", desc = "Inner comment" },
            ["ati"] = { query = "@conditional.outer", desc = "Outer conditional" },
            ["iti"] = { query = "@conditional.inner", desc = "Inner conditional" },
            ["atb"] = { query = "@block.outer", desc = "Outer block" },
            ["itb"] = { query = "@block.inner", desc = "Inner block" },
            ["atl"] = { query = "@loop.outer", desc = "Outer loop" },
            ["itl"] = { query = "@loop.inner", desc = "Inner loop" },
            ["ats"] = { query = "@statement.outer", desc = "Outer statement" },
            ["its"] = { query = "@statement.inner", desc = "Inner statement" },
            ["ata"] = { query = "@assignment.outer", desc = "Outer assignment" },
            ["ita"] = { query = "@assignment.inner", desc = "Inner assignment" },
            ["itla"] = { query = "@assignment.lhs", desc = "LHS assignment" },
            ["itra"] = { query = "@assignment.rhs", desc = "RHS assignment" },
            ["atk"] = { query = "@class.outer", desc = "Outer class" },
            ["itk"] = { query = "@class.inner", desc = "Inner class" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Whether to set jumps in the jumplist
          goto_next_start = {
            ["]tf"] = { query = "@function.outer", desc = "Next function" },
            ["]tp"] = { query = "@parameter.outer", desc = "Next parameter" },
            ["]tc"] = { query = "@call.outer", desc = "Next function call" },
            ["]to"] = { query = "@comment.outer", desc = "Next comment" },
            ["]ti"] = { query = "@conditional.outer", desc = "Next conditional" },
            ["]tb"] = { query = "@block.outer", desc = "Next block" },
            ["]tl"] = { query = "@loop.outer", desc = "Next loop" },
            ["]ts"] = { query = "@statement.outer", desc = "Next statement" },
            ["]ta"] = { query = "@assignment.outer", desc = "Next assignment" },
            ["]tk"] = { query = "@class.outer", desc = "Next class" },
          },
          goto_next_end = {
            ["]tF"] = { query = "@function.outer", desc = "Next function" },
            ["]tP"] = { query = "@parameter.outer", desc = "Next parameter" },
            ["]tC"] = { query = "@call.outer", desc = "Next function call" },
            ["]tO"] = { query = "@comment.outer", desc = "Next comment" },
            ["]tI"] = { query = "@conditional.outer", desc = "Next conditional" },
            ["]tB"] = { query = "@block.outer", desc = "Next block" },
            ["]tL"] = { query = "@loop.outer", desc = "Next loop" },
            ["]tS"] = { query = "@statement.outer", desc = "Next statement" },
            ["]tA"] = { query = "@assignment.outer", desc = "Next assignment" },
            ["]tK"] = { query = "@class.outer", desc = "Next class" },
          },
          goto_previous_start = {
            ["[tf"] = { query = "@function.outer", desc = "Previous function" },
            ["[tp"] = { query = "@parameter.outer", desc = "Previous parameter" },
            ["[tc"] = { query = "@call.outer", desc = "Previous function call" },
            ["[to"] = { query = "@comment.outer", desc = "Previous comment" },
            ["[ti"] = { query = "@conditional.outer", desc = "Previous conditional" },
            ["[tb"] = { query = "@block.outer", desc = "Previous block" },
            ["[tl"] = { query = "@loop.outer", desc = "Previous loop" },
            ["[ts"] = { query = "@statement.outer", desc = "Previous statement" },
            ["[ta"] = { query = "@assignment.outer", desc = "Previous assignment" },
            ["[tk"] = { query = "@class.outer", desc = "Previous class" },
          },
          goto_previous_end = {
            ["[tF"] = { query = "@function.outer", desc = "Previous function" },
            ["[tP"] = { query = "@parameter.outer", desc = "Previous parameter" },
            ["[tC"] = { query = "@call.outer", desc = "Previous function call" },
            ["[tO"] = { query = "@comment.outer", desc = "Previous comment" },
            ["[tI"] = { query = "@conditional.outer", desc = "Previous conditional" },
            ["[tB"] = { query = "@block.outer", desc = "Previous block" },
            ["[tL"] = { query = "@loop.outer", desc = "Previous loop" },
            ["[tS"] = { query = "@statement.outer", desc = "Previous statement" },
            ["[tA"] = { query = "@assignment.outer", desc = "Previous assignment" },
            ["[tK"] = { query = "@class.outer", desc = "Previous class" },
          },
        },
      },
    })
  end,
}
