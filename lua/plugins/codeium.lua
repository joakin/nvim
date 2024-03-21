-- No default bindings
vim.g.codeium_disable_bindings = 1

return {
  "Exafunction/codeium.vim",
  config = function()
    local opts = { noremap = true, silent = true }
    local expr_opts = {
      noremap = true,
      silent = true,
      expr = true,
      -- With expr = true, replace_keycodes is set to true. See https://github.com/orgs/community/discussions/29817
      -- We need to set it to false to avoid extraneous caracters when accepting a suggestion.
      replace_keycodes = false,
    }

    vim.keymap.set("i", "<C-J>", "codeium#Accept()", expr_opts)
    vim.keymap.set("i", "<C-G><C-J>", "codeium#Accept()", expr_opts)
    vim.keymap.set("i", "<C-G><C-G>", "codeium#Complete()", expr_opts)
    vim.keymap.set("i", "<C-G><C-E>", "codeium#Clear()", expr_opts)
    vim.keymap.set("i", "<C-G><C-N>", "codeium#CycleCompletions( 1)", expr_opts)
    vim.keymap.set("i", "<C-G><C-P>", "codeium#CycleCompletions(-1)", expr_opts)

    local function getCodeiumCompletions()
      local status, completion = pcall(function()
        return vim.api.nvim_eval("b:_codeium_completions.items[b:_codeium_completions.index].completionParts[0].text")
      end)
      if status then
        return completion
      else
        return ""
      end
    end
    local function accept_one_line()
      local text = getCodeiumCompletions()
      return vim.fn.split(text, [[[\n]\zs]])[1] .. "\n"
    end
    local function accept_one_word()
      local text = getCodeiumCompletions()
      local words = vim.fn.split(text, [[\(\w\+\|\W\+\)\zs]])
      if words[1] == " " then
        return words[1] .. words[2]
      else
        return words[1]
      end
    end

    vim.keymap.set("i", "<C-L>", accept_one_line, expr_opts)
    vim.keymap.set("i", "<C-G><C-L>", accept_one_word, expr_opts)
  end,
}
