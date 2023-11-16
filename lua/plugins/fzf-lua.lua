return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "junegunn/fzf", build = "./install --bin" },
  },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    fzf.setup({
      keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<C-H>"] = "toggle-help",
          ["<C-space>"] = "toggle-fullscreen",
          ["<C-L><C-L>"] = "toggle-preview",
          ["<C-L><C-W>"] = "toggle-preview-wrap",
          ["<C-L><C-B>"] = "toggle-preview-ccw",
          ["<C-L><C-R>"] = "toggle-preview-cw",
          ["<C-L><C-D>"] = "preview-page-down",
          ["<C-L><C-U>"] = "preview-page-up",
          ["<C-L><C-G>"] = "preview-page-reset",
        },
        fzf = {
          -- fzf '--bind=' options
          -- ["esc"] = "abort",
          -- ["ctrl-u"] = "unix-line-discard",
          ["ctrl-u"] = "half-page-down",
          ["ctrl-d"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          -- ["f3"] = "toggle-preview-wrap",
          -- ["f4"] = "toggle-preview",
          -- ["shift-down"] = "preview-page-down",
          -- ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        buffers = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
          ["backspace"] = actions.buf_delete,
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

    vim.keymap.set("n", "<leader>f", function()
      fzf.files()
    end, { desc = "List files" })
    -- vim.keymap.set("n", "<leader>F", function()
    -- TODO: What to do here?
    --   fzf.files({})
    -- end, { desc = "List *all* files" })
    vim.keymap.set("n", "<leader>b", function()
      fzf.buffers()
    end, { desc = "List buffers" })
    vim.keymap.set("n", "<leader>sf", function()
      fzf.oldfiles()
    end, { desc = "List recent files" })

    vim.keymap.set("n", "<leader>sb", function()
      fzf.blines()
    end, { desc = "Search *in* buffer" })
    vim.keymap.set("n", "<leader>/", function()
      fzf.blines()
    end, { desc = "Search *in* buffer" })
    vim.keymap.set("n", "<leader>ss", function()
      fzf.live_grep()
    end, { desc = "Search in files" })
    -- vim.keymap.set("n", "<leader>sS", function()
    -- TODO: What to do here?
    --   fzf.live_grep()
    -- end, { desc = "Search in *all* files" })
    vim.keymap.set("n", "gS", function()
      fzf.live_grep()
    end, { desc = "Search in files" })
    vim.keymap.set({ "n" }, "gs", function()
      fzf.grep_cword()
    end, { desc = "Search word under cursor in files" })
    vim.keymap.set({ "x" }, "gs", function()
      fzf.grep_visual()
    end, { desc = "Search selected text in files" })

    vim.keymap.set("n", "<leader>sh", function()
      fzf.help_tags()
    end, { desc = "List help tags" })
    vim.keymap.set("n", "<leader>sc", function()
      fzf.commands()
    end, { desc = "List commands" })
    vim.keymap.set("n", "<leader>s/", function()
      fzf.search_history()
    end, { desc = "List search history" })
    vim.keymap.set("n", "<leader>s:", function()
      fzf.command_history()
    end, { desc = "List command history" })
    vim.keymap.set("n", "<leader>s;", function()
      fzf.command_history()
    end, { desc = "List command history" })
    vim.keymap.set("n", "<leader>sm", function()
      fzf.marks()
    end, { desc = "List marks" })
    vim.keymap.set("n", "<leader>sr", function()
      fzf.registers()
    end, { desc = "List registers" })

    vim.keymap.set("n", "<leader>sgc", function()
      fzf.git_commits()
    end, { desc = "List git commits" })
    vim.keymap.set("n", "<leader>sgb", function()
      fzf.git_branches()
    end, { desc = "List git branches" })

    vim.keymap.set("n", "<leader>st", function()
      fzf.resume()
    end, { desc = "Open last picker" })
  end,
}
