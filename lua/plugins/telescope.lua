local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- Disable folding in Telescope's result window.
local telescope_results_autocmd = vim.api.nvim_create_augroup("TelescopeResults", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  group = telescope_results_autocmd,
  callback = function()
    vim.opt_local.foldenable = false
  end,
})

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.cycle_history_next,
      },
    },
  },
})

-- If rg or fzf are not executables, print an error message prompting the user to install them.
if vim.fn.executable("rg") == 0 then
  -- Required for live_grep
  error("rg is not installed.")
end
if vim.fn.executable("fzf") == 0 then
  error("fzf is not installed.")
end

telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "List files" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope oldfiles<cr>", { desc = "List recent files" })

vim.keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search *in* buffer" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search *in* buffer" })
vim.keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
vim.keymap.set("n", "gS", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
vim.keymap.set({ "n" }, "gs", "<cmd>Telescope grep_string<cr>", { desc = "Search word under cursor in files" })
vim.keymap.set({ "x" }, "gs", function()
  vim.cmd([[noau normal! "zy']])
  local text = vim.fn.getreg("z")
  builtin.grep_string({ search = text })
end, { desc = "Search selected text in files" })

vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "List help tags" })
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "List commands" })
vim.keymap.set("n", "<leader>s/", "<cmd>Telescope search_history<cr>", { desc = "List search history" })
vim.keymap.set("n", "<leader>s:", "<cmd>Telescope command_history<cr>", { desc = "List command history" })
vim.keymap.set("n", "<leader>s;", "<cmd>Telescope command_history<cr>", { desc = "List command history" })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "List marks" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope registers<cr>", { desc = "List registers" })

vim.keymap.set("n", "<leader>sgc", "<cmd>Telescope git_commits<cr>", { desc = "List git commits" })
vim.keymap.set("n", "<leader>sgb", "<cmd>Telescope git_branches<cr>", { desc = "List git branches" })
