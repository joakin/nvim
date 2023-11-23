-- Telescope
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local multi_open_mappings = require("plugins.telescope.multi_open_mappings")

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
          i = vim.tbl_extend("force", {
            ["<esc>"] = "close",
            ["<C-k>"] = "move_selection_previous",
            ["<C-j>"] = "move_selection_next",
            ["<C-p>"] = "cycle_history_prev",
            ["<C-n>"] = "cycle_history_next",
            ["<C-l>"] = require("telescope.actions.layout").toggle_preview,
          }, multi_open_mappings.i),
          n = multi_open_mappings.n,
        },
        preview = {
          -- hide_on_startup = true, -- hide previewer when picker starts
        },
        path_display = { truncate = 1 },
        file_ignore_patterns = { "^.git/", "node_modules/", "elm-stuff/" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          mappings = {
            i = {
              ["<C-bs>"] = "delete_buffer",
            },
          },
          sort_mru = true,
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
    vim.keymap.set("n", "<leader>F", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "List *all* files" })
    vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
    vim.keymap.set("n", "<leader>sf", "<cmd>Telescope oldfiles<cr>", { desc = "List recent files" })

    vim.keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search *in* buffer" })
    vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search *in* buffer" })
    vim.keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
    vim.keymap.set("n", "<leader>sS", function()
      builtin.live_grep({ hidden = true, no_ignore = true })
    end, { desc = "Search in *all* files" })
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

    vim.keymap.set("n", "<leader>st", "<cmd>Telescope resume<cr>", { desc = "Open last picker" })
  end,
}
