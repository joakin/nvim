-- Copilot

-- no_tab_map needs to be set before loading the plugin
vim.g.copilot_no_tab_map = true

return {
  "github/copilot.vim",
  enabled = false,
  config = function()
    vim.g.copilot_filetypes = {
      gitcommit = true,
      markdown = true,
      json = true,
      yaml = true,
    }

    local opts = { noremap = true, silent = true }
    local expr_opts = {
      noremap = true,
      silent = true,
      expr = true,
      -- With expr = true, replace_keycodes is set to true. See https://github.com/orgs/community/discussions/29817
      -- We need to set it to false to avoid extraneous caracters when accepting a suggestion.
      replace_keycodes = false,
    }

    vim.keymap.set("i", "<C-G><C-J>", "copilot#Accept('<CR>')", expr_opts)
    vim.keymap.set("i", "<C-J>", "copilot#Accept('<CR>')", expr_opts)
    vim.keymap.set("i", "<C-G><C-G>", "<Plug>(copilot-suggest)", opts)
    vim.keymap.set("i", "<C-G><C-E>", "<Plug>(copilot-dismiss)", opts)
    vim.keymap.set("i", "<C-G><C-N>", "<Plug>(copilot-next)", opts)
    vim.keymap.set("i", "<C-G><C-P>", "<Plug>(copilot-previous)", opts)

    local function accept_one_line()
      local suggestion = vim.fn["copilot#Accept"]("")
      local text = vim.fn["copilot#TextQueuedForInsertion"]()
      return vim.fn.split(text, [[[\n]\zs]])[1]
    end
    local function accept_one_word()
      local suggestion = vim.fn["copilot#Accept"]("")
      local text = vim.fn["copilot#TextQueuedForInsertion"]()
      return vim.fn.split(text, [[\(\w\+\|\W\+\)\zs]])[1]
    end

    vim.keymap.set("i", "<C-L>", accept_one_line, expr_opts)
    vim.keymap.set("i", "<C-G><C-L>", accept_one_word, expr_opts)
  end,
}
