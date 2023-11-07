-- Init {{{
local isMac = false
if vim.fn.has("macunix") == true then
  isMac = true
end
local isWindows = false
if vim.fn.has("win32") == true then
  isWindows = true
end
local isLinux = false
if vim.fn.has("unix") == true then
  isLinux = true
end
local isWSL = false
if isLinux and vim.fn.executable("wslview") then
  isWSL = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- }}}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugins/Packages {{{

require("lazy").setup({
  -- Neovim {{{
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("plugins/telescope")
    end,
  },

  -- LSP servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",

      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },

      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("config/lsp")
    end,
  },

  -- Autocompletion & Snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("plugins/luasnip")
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      -- Completion sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require("plugins/cmp")
    end,
  },

  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          require("plugins/treesitter-textobjects")
        end,
      },
    },
    build = ":TSUpdate",
    config = function()
      require("plugins/treesitter")
    end,
  },
  -- }}}

  -- Basics {{{
  -- Show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },
  -- Enable repeat for plugins that support it
  "tpope/vim-repeat",
  -- Fix some netrw ( - for up dir, . or ! for cmd with file, cg/cl to cd/lcd, ~ )
  "tpope/vim-vinegar",
  -- Like f but multiline and faster 's'
  "justinmk/vim-sneak",
  -- Align text :Tabularize
  "godlygeek/tabular",
  -- Change surrounding delimiters (cs"')
  "tpope/vim-surround",
  -- c-a c-x for dates
  "tpope/vim-speeddating",
  -- Tons of useful mappings
  "tpope/vim-unimpaired",
  -- Abbreviations, Substitutions, Coercion...
  "tpope/vim-abolish",
  -- Readline mappings
  "tpope/vim-rsi",
  -- Auto detect indent settings
  "tpope/vim-sleuth",
  -- Distraction free editing mode (:ZenMode)
  "folke/zen-mode.nvim",
  -- Comment and uncomment code with gc{motion} (gcc gcgc)
  "tpope/vim-commentary",
  -- Put the results of "include-search" and "definition-search" in the quickfix
  -- List instead of the default list-like interface ([I, [D, ...)
  "romainl/vim-qlist",
  -- Local .vimrc sourcing on folders
  "MarcWeber/vim-addon-local-vimrc",
  -- Fast folds - Recompute folds only on certain actions
  "Konfekt/FastFold",
  -- }}}

  -- Text Objects {{{
  -- il al
  { "kana/vim-textobj-line", dependencies = "kana/vim-textobj-user" },
  -- iz az
  { "kana/vim-textobj-fold", dependencies = "kana/vim-textobj-user" },
  -- ie ae
  { "kana/vim-textobj-entire", dependencies = "kana/vim-textobj-user" },
  -- ai ii aI iI
  "qstrahl/vim-dentures",
  -- ic ac iC aC
  "coderifous/textobj-word-column.vim",
  -- }}}

  -- Syntax {{{
  "pangloss/vim-javascript",
  "MaxMEllon/vim-jsx-pretty",
  "leshill/vim-json",
  "mustache/vim-mustache-handlebars",
  "tpope/vim-markdown",
  "stephpy/vim-yaml", -- Vim 7.4 yaml syntax is horrible slow
  "tikhomirov/vim-glsl",
  "cespare/vim-toml",
  "briancollins/vim-jst",
  -- }}}

  -- Languages {{{

  -- Elm {{{
  "andys8/vim-elm-syntax",
  -- }}}

  -- Rescript {{{
  "rescript-lang/vim-rescript",
  -- }}}

  -- Typescript {{{
  -- Syntax
  "leafgarland/typescript-vim",
  -- }}}

  -- CSS {{{
  "1995eaton/vim-better-css-completion",
  "groenewege/vim-less",
  "cakebaker/scss-syntax.vim",
  -- }}}

  -- Rust {{{
  -- Language files
  "rust-lang/rust.vim",
  -- }}}

  -- GraphQL {{{
  "jparise/vim-graphql",
  -- }}}

  -- Odin {{{
  "Tetralux/odin.vim",
  -- }}}
  -- }}}

  -- External tools {{{
  -- Git commands
  "tpope/vim-fugitive", -- Gcommit, Gstatus, Gdiff, etc.
  "junegunn/gv.vim", -- GV(!?)
  "tpope/vim-rhubarb", -- Support github for Gbrowse
  -- Unix commands (Delete, Remove, Move, Chmod, Mkdir, Find, Locate, Wall, SudoWrite, SudoEdit)
  "tpope/vim-eunuch",
  -- Copilot
  {
    "github/copilot.vim",
    config = function()
      require("plugins/copilot")
    end,
  },
  -- }}}

  -- Internets {{{
  -- Upload gists with :Gist
  { "mattn/gist-vim", dependencies = { "mattn/webapi-vim" } },
  -- }}}

  -- Color schemes {{{
  "jonathanfilip/vim-lucius",
  "nanotech/jellybeans.vim",
  "noahfrederick/Hemisu",
  "fxn/vim-monochrome",
  "sjl/badwolf",
  "reedes/vim-colors-pencil",
  "gruvbox-community/gruvbox",
  "tpope/vim-vividchalk",
  "NLKNguyen/papercolor-theme",
  "altercation/vim-colors-solarized",
  "robertmeta/nofrils",
  "chriskempson/base16-vim",
  "rakr/vim-one",
  -- }}}
})

-- }}}

-- Settings {{{

-- Set a short key capture time on terminal. Else it takes a second to process " Esc...
if vim.fn.has("gui_running") == 0 then
  vim.opt.ttimeoutlen = 100
end

vim.opt.termguicolors = true

-- Tab size
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.undofile = true -- Create undo files with history
vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
vim.opt.formatoptions = { c = true, r = true, o = true, q = true, n = true, ["1"] = true }
vim.opt.copyindent = true -- copy the previous indentation on autoindenting
vim.opt.hidden = true -- Allow modified/unsaved buffers in the background.

vim.opt.ignorecase = true -- Not case sensitive search
vim.opt.smartcase = true -- Unless the search contains caps letters
vim.opt.hlsearch = true -- highlight search terms
vim.opt.gdefault = true -- Default g flag on substitutions
vim.opt.inccommand = "split"

vim.opt.showmatch = true -- Jump to bracket/parens briefly
vim.opt.matchtime = 1 --  Time of the jump of showmatch

local directory = vim.fn.expand("~/.nvimswap/")
vim.opt.directory = directory
local undodir = vim.fn.expand("~/.nvimundo/")
vim.opt.undodir = undodir
-- Make those folders automatically if they don't already exist.
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
if vim.fn.isdirectory(directory) == 0 then
  vim.fn.mkdir(directory, "p")
end

vim.opt.completeopt = { "menu", "menuone", "preview" } --  ,"noinsert","noselect"

vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.synmaxcol = 300 --  Don't try to highlight lines longer than
vim.opt.mouse = { a = true }

vim.opt.switchbuf = { "useopen", "usetab" } --  When available switch to open buffers in current and different tabs
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 1

-- FoldText {{{
vim.cmd([[
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    --  expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()
]])

-- }}}

vim.opt.foldenable = true
vim.opt.foldlevelstart = 0
vim.opt.foldmarker = { "{{{", "}}}" }
vim.opt.foldmethod = "indent"

-- Invisible char settings (list)
vim.opt.listchars = { tab = "» ", trail = "·", extends = "…", precedes = "…", nbsp = "&", eol = "¬" }

-- Spell stuff
vim.opt.spellfile = "$HOME/.vim/spell/custom.utf-8.add"

-- Separators and fillchar
vim.opt.fillchars = { vert = "│", fold = "─", diff = "━", stlnc = "-" }

-- Use the system clipboard by default
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Split panels to the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

if vim.fn.has("gui_running") == 1 then
  if isWindows then
    vim.cmd([[ GuiFont! LigaLex Mono:h12 ]])
    vim.opt.linespace = 6
  elseif isLinux then
    vim.opt.gfn = "monospace 14"
    vim.opt.linespace = 2
  elseif isMac then
    vim.opt.macligatures = true
    vim.opt.gfn = "LigaLex Mono:h16"
    vim.opt.linespace = 8
  end

  vim.cmd([[
    set guioptions="c"
    set guioptions-="T"
  ]])
end
vim.opt.wildignore:append({
  ".hg",
  ".git",
  ".svn", --  Version control
  "*.aux",
  "*.out",
  "*.toc", --  LaTeX intermediate files
  "*.jpg",
  "*.bmp",
  "*.gif",
  "*.png",
  "*.jpeg", --  binary images
  "*.o",
  "*.obj",
  "*.exe",
  "*.dll",
  "*.manifest", --  compiled object files
  "*.spl", --  compiled spelling word lists
  "*.sw?", --  Vim swap files
  "*.DS_Store", --  OSX bullshit
  "target/", --  Clojure
  "node_modules/", --  JS
  "elm-stuff/", --  Elm
})

-- Highlight git conflict markers
vim.cmd([[match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$']])

-- Default to conceal enabled
vim.opt.conceallevel = 2

-- Popup menu
vim.opt.pumheight = 5
if vim.opt.termguicolors:get() then
  vim.opt.pumblend = 3
end

-- }}}

-- Plugins {{{

-- vim-markdown {{{
vim.g.markdown_syntax_conceal = 1
-- }}}

-- netrw {{{
-- Use single column with details (1). (3) is the tree view
vim.g.netrw_liststyle = 1
if isWSL then
  vim.g.netrw_browsex_viewer = "wslview"
end
-- }}}

-- Gist {{{
if isMac then
  vim.g.gist_clip_command = "pbcopy"
elseif isLinux then
  vim.g.gist_clip_command = "xclip -selection clipboard"
elseif isWindows then
  vim.g.gist_clip_command = "clip.exe"
end
vim.g.gist_detect_filetype = 1
vim.g.gist_open_browser_after_post = 1
-- }}}

-- rsi {{{
-- Breaks macros on the terminal
vim.g.rsi_no_meta = 1
-- }}}

-- mustache-handlebars {{{
-- don't enable the ie/ae text objects as we have the entire file ones
vim.g.mustache_operators = 0
-- }}}

-- }}}

-- Mappings {{{

-- Vim {{{

-- Repeat search & replace
vim.keymap.set("n", "&", ":&&<CR>", { desc = "Repeat search with flags" })
vim.keymap.set("x", "&", ":&&<CR>", { desc = "Repeat search with flags" })

-- Make . work with a visual selection
vim.keymap.set("v", ".", ":normal .<cr>", { desc = ". repeat with a visual selection" })

-- Easier omnicompletion
vim.keymap.set("i", "<c-space>", "<C-X><C-O>")

-- Manipulate windows (shortcuts)
vim.keymap.set(
  "n",
  "<C-W><C-F>",
  "<C-W>_:vertical resize<cr>",
  { desc = "Maximize window, make it as big as possible" }
)
vim.keymap.set("n", "<C-W><C-E>", "<C-W>=", { desc = "Make all windows equal size" })
vim.keymap.set("n", "<C-W>+", "<C-W>10+", { desc = "Make window taller" })
vim.keymap.set("n", "<C-W>-", "<C-W>10-", { desc = "Make window shorter" })
vim.keymap.set("n", "<C-W><", "<C-W>20<", { desc = "Make window thiner" })
vim.keymap.set("n", "<C-W>>", "<C-W>20>", { desc = "Make window wider" })

-- Formatting
vim.keymap.set("n", "Q", "gqip", { desc = "Text format inner paragraph" })
vim.keymap.set("v", "Q", "gq", { desc = "Text format inner paragraph" })

-- Center screen when moving
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Same when jumping around
vim.keymap.set("n", "g;", "g;zzzv")
vim.keymap.set("n", "g,", "g,zzzv")
vim.keymap.set("n", "<c-o>", "<c-o>zzzv")
vim.keymap.set("n", "<c-i>", "<c-i>zzzv")

-- Line-wise movements
vim.keymap.set("n", "H", "^", { desc = "Go to beginning of line" })
vim.keymap.set("v", "H", "^", { desc = "Go to beginning of line" })
vim.keymap.set("n", "L", "$", { desc = "Go to end of line" })
vim.keymap.set("v", "L", "g_", { desc = "Go to end of line" })
vim.keymap.set("n", "gH", "H", { desc = "Move cursor to top of window" })
vim.keymap.set("n", "gL", "L", { desc = "Move cursor to bottom of window" })

-- gI
-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
vim.keymap.set("n", "gI", "`.", { desc = "Move to last change" })

-- Folds
-- Space to toggle folds.
vim.keymap.set("n", "z<space>", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "zO", "zczO", { desc = "Open folds to cursor" })

-- "Focus" the current line
-- 1. Close all folds.
-- 2. Open just the folds containing the current line.
-- 3. Move the line to a little bit (15 lines) above the center of the screen.
-- 4. Pulse the cursor line.
-- This mapping wipes out the z mark, which I never use.
vim.keymap.set(
  "n",
  "z<cr>",
  "mzzMzvzczOzz1<c-e>`z:Pulse<cr>",
  { desc = "Focus current line, opening fold and closing the rest" }
)

-- Command line maps
vim.keymap.set("c", "%%", function()
  if vim.fn.getcmdtype() == ":" then
    return vim.fn.expand("%:h") .. "/"
  else
    return "%%"
  end
end, { expr = true, desc = "Expand into current file's folder" })
vim.keymap.set("c", "<c-n>", "<down>", { desc = "Previous command" })
vim.keymap.set("c", "<c-p>", "<up>", { desc = "Next command" })

-- Colon and Semi-colon mappings
-- Easier : reach, and saner ; map
-- Now, ; goes avanti with f/F t/T and <shift-;> goes backwards
-- Also command line goes to , which is better than <shift-;>
vim.keymap.set("n", ",", ":", { desc = "Enter command mode" })
vim.keymap.set("x", ",", ":", { desc = "Enter command mode" })
vim.keymap.set("n", ":", ",", { desc = "Previous char match" })
vim.keymap.set("x", ":", ",", { desc = "Previous char match" })

-- Easy filetype changing {{{
vim.keymap.set("n", "yoft", ":set filetype=txt<cr>", { desc = 'Set filetype to "txt"' })
vim.keymap.set("n", "yofj", ":set filetype=javascript<cr>", { desc = "Set filetype to JS" })
vim.keymap.set("n", "yofm", ":set filetype=markdown<cr>", { desc = "Set filetype to markdown" })
vim.keymap.set("n", "yofv", ":set filetype=vim<cr>", { desc = "Set filetype to vim" })
vim.keymap.set("n", "yofc", ":set filetype=clojure<cr>", { desc = "Set filetype to clojure" })
vim.keymap.set("n", "yoff", ":set filetype=", { desc = "Set filetype (prompt)" })
vim.keymap.set("n", "yof", ":set filetype=", { desc = "Set filetype (prompt)" })
-- }}}

-- Moving back and forth between lines of same or lower indentation {{{
vim.keymap.set(
  "n",
  "<c-k>",
  ":call mappings#NextIndent(0, 0, 0 )<CR>_",
  { silent = true, desc = "Move up to previous line with same indent" }
)
vim.keymap.set(
  "n",
  "<c-j>",
  ":call mappings#NextIndent(0, 1, 0 )<CR>_",
  { silent = true, desc = "Move up to next line with same indent" }
)
vim.keymap.set(
  "n",
  "<c-h>",
  ":call mappings#NextIndent(0, 0, -1)<CR>_",
  { silent = true, desc = "Move up to previous less indented line" }
)
vim.keymap.set(
  "n",
  "<c-l>",
  ":call mappings#NextIndent(0, 1, 1 )<CR>_",
  { silent = true, desc = "Move down to next more indented line" }
)
-- nnoremap <silent> <c-L> :call      mappings#NextIndent(0, 0, 1 )<CR>_
-- nnoremap <silent> <c-H> :call      mappings#NextIndent(0, 1, -1)<CR>_
vim.keymap.set(
  "v",
  "<c-k>",
  [[<Esc>:call mappings#NextIndent(0, 0, 0 )<CR>m'gv'']],
  { silent = true, desc = "Move up to previous line with same indent" }
)
vim.keymap.set(
  "v",
  "<c-j>",
  [[<Esc>:call mappings#NextIndent(0, 1, 0 )<CR>m'gv'']],
  { silent = true, desc = "Move up to next line with same indent" }
)
vim.keymap.set(
  "v",
  "<c-h>",
  [[<Esc>:call mappings#NextIndent(0, 0, -1)<CR>m'gv'']],
  { silent = true, desc = "Move up to previous less indented line" }
)
vim.keymap.set(
  "v",
  "<c-l>",
  [[<Esc>:call mappings#NextIndent(0, 1, 1 )<CR>m'gv'']],
  { silent = true, desc = "Move down to next more indented line" }
)
-- vnoremap <silent> <c-L> <Esc>:call mappings#NextIndent(0, 0, 1 )<CR>m'gv''
-- vnoremap <silent> <c-H> <Esc>:call mappings#NextIndent(0, 1, -1)<CR>m'gv''
vim.keymap.set(
  "o",
  "<c-k>",
  ":<c-u>normal V<c-v><c-k><cr>",
  { silent = true, desc = "Move up to previous line with same indent" }
)
vim.keymap.set(
  "o",
  "<c-j>",
  ":<c-u>normal V<c-v><c-j><cr>",
  { silent = true, desc = "Move up to next line with same indent" }
)
vim.keymap.set(
  "o",
  "<c-h>",
  ":<c-u>normal V<c-v><c-h>j<cr>",
  { silent = true, desc = "Move up to previous less indented line" }
)
vim.keymap.set(
  "o",
  "<c-l>",
  ":<c-u>normal V<c-v><c-l>k<cr>",
  { silent = true, desc = "Move down to next more indented line" }
)
-- onoremap <silent> <c-L> _:call     mappings#NextIndent(0, 0, 1 )<CR>_
-- onoremap <silent> <c-H> $:call     mappings#NextIndent(0, 1, -1)<CR>$
-- }}}

-- Highlight Word {{{
function InterestingWordsUpdateHighlight()
  vim.cmd([[
  hi! def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
  hi! def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
  hi! def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#00afff ctermbg=39
  hi! def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
  hi! def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
  hi! def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#df0000 ctermbg=160
  hi! def InterestingWord7 guifg=#000000 ctermfg=16 guibg=#df5fff ctermbg=171
  hi! def InterestingWord8 guifg=#000000 ctermfg=16 guibg=#c0c0c0 ctermbg=7
  hi! def InterestingWord9 guifg=#000000 ctermfg=16 guibg=#00ffff ctermbg=14
  ]])
end

InterestingWordsUpdateHighlight()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("InterestingWords", { clear = true }),
  callback = function()
    InterestingWordsUpdateHighlight()
  end,
})

vim.keymap.set("n", "<leader>1", ":call mappings#HiInterestingWord(0, 1)<cr>", { desc = "Highlight word yellow" })
vim.keymap.set("n", "<leader>2", ":call mappings#HiInterestingWord(0, 2)<cr>", { desc = "Highlight word green" })
vim.keymap.set("n", "<leader>3", ":call mappings#HiInterestingWord(0, 3)<cr>", { desc = "Highlight word blue" })
vim.keymap.set("n", "<leader>4", ":call mappings#HiInterestingWord(0, 4)<cr>", { desc = "Highlight word brown" })
vim.keymap.set("n", "<leader>5", ":call mappings#HiInterestingWord(0, 5)<cr>", { desc = "Highlight word pink" })
vim.keymap.set("n", "<leader>6", ":call mappings#HiInterestingWord(0, 6)<cr>", { desc = "Highlight word red" })
vim.keymap.set("n", "<leader>7", ":call mappings#HiInterestingWord(0, 7)<cr>", { desc = "Highlight word purple" })
vim.keymap.set("n", "<leader>8", ":call mappings#HiInterestingWord(0, 8)<cr>", { desc = "Highlight word grey" })
vim.keymap.set("n", "<leader>9", ":call mappings#HiInterestingWord(0, 9)<cr>", { desc = "Highlight word cyan" })
vim.keymap.set("x", "<leader>1", ":call mappings#HiInterestingWord(1, 1)<cr>", { desc = "Highlight word yellow" })
vim.keymap.set("x", "<leader>2", ":call mappings#HiInterestingWord(1, 2)<cr>", { desc = "Highlight word green" })
vim.keymap.set("x", "<leader>3", ":call mappings#HiInterestingWord(1, 3)<cr>", { desc = "Highlight word blue" })
vim.keymap.set("x", "<leader>4", ":call mappings#HiInterestingWord(1, 4)<cr>", { desc = "Highlight word brown" })
vim.keymap.set("x", "<leader>5", ":call mappings#HiInterestingWord(1, 5)<cr>", { desc = "Highlight word pink" })
vim.keymap.set("x", "<leader>6", ":call mappings#HiInterestingWord(1, 6)<cr>", { desc = "Highlight word red" })
vim.keymap.set("x", "<leader>7", ":call mappings#HiInterestingWord(1, 7)<cr>", { desc = "Highlight word purple" })
vim.keymap.set("x", "<leader>8", ":call mappings#HiInterestingWord(1, 8)<cr>", { desc = "Highlight word grey" })
vim.keymap.set("x", "<leader>9", ":call mappings#HiInterestingWord(1, 9)<cr>", { desc = "Highlight word cyan" })
-- }}}

-- Map search to very magic by default
vim.keymap.set("n", "/", "/\\v", { desc = "Search (very magical flag)" })
vim.keymap.set("n", "?", "?\\v", { desc = "Search back (very magical flag)" })

-- CTRL+SHIFT+6 to something easier
vim.keymap.set("n", "<leader>n", "<c-^>", { desc = "Go to alternate file" })

-- Terminal settings {{{
-- Default <ESC> to exiting term mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- }}}

-- }}}

-- Leader {{{

-- Substitute shortcut
vim.keymap.set("n", "<leader>r", ":%s/\\v", { desc = "Search and replace in file" })
vim.keymap.set("x", "<leader>r", ":s/\\v", { desc = "Search and replace in file" })

-- Opening stuff (files, windows, etc)
-- Files:
-- ...
-- Windows/buffers:
vim.keymap.set("n", "<leader>ot", ":tabe<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>ov", ":vsp<cr>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>os", ":sp<cr>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>oc", ":term<cr>", { desc = "New terminal" })
vim.keymap.set("n", "<leader>oq", ":copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>ol", ":lopen<cr>", { desc = "Open location list" })
vim.keymap.set("n", "<leader>on", ":enew<cr>", { desc = "New empty buffer" })

-- Fast saving & quitting
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>u", ":bd<cr>", { desc = "Delete buffer" })

-- Set local path
vim.keymap.set("n", "<leader>p", ":lcd %:p:h<CR>:pwd<CR>", { desc = "Set local path to current file's path" })
-- }}}

-- }}}

-- Commands {{{

vim.api.nvim_create_user_command("CopyMatches", "call commands#CopyMatches(<q-reg>)", {
  desc = "Copy search matches to the quickfix list",
  nargs = 0,
  register = true,
})

vim.api.nvim_create_user_command("Pulse", "call commands#Pulse()", {
  desc = "Pulse the current line",
  nargs = 0,
})

vim.api.nvim_create_user_command("Qargs", "execute 'args ' . commands#QuickfixFilenames()", {
  desc = "Place the quickfix list files in the arg list",
  bar = true,
  nargs = 0,
})

vim.api.nvim_create_user_command("FollowSymlink", ":exec 'file ' . resolve(expand('%:p')) | e", {
  desc = "Place the quickfix list files in the arg list",
  nargs = 0,
})

vim.api.nvim_create_user_command(
  "SyntaxInfo",
  [[
    :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
  ]],
  {
    desc = "Print syntax information for tokens under the cursor",
    nargs = 0,
  }
)

vim.api.nvim_create_user_command("ToggleConceal", "call mappings#ToggleConceal(1)", {
  desc = "Place the quickfix list files in the arg list",
  nargs = 0,
})

-- Toggle "keep current line in the center of the screen" mode
vim.api.nvim_create_user_command("LockCursorInCenterOfScreen ", "let &scrolloff=999-&scrolloff", {
  desc = "Keep current line in the center of the screen",
  nargs = 0,
})

vim.api.nvim_create_user_command("SyntaxSyncFromStart", ":syntax sync fromstart", {
  desc = "Sync the file syntax from the start of the file",
  nargs = 0,
})

-- }}}

-- Statusline {{{
function MyFugitiveStatusline()
  local str = vim.fn.FugitiveStatusline()
  return string.match(str, "%((.-)%)") or ""
end

local function statusline()
  local s = ""
  s = s .. "%3*" -- Switch to User3 highlight group.
  s = s .. " " -- Space
  s = s .. "%n" -- Buffer number
  s = s .. " " -- Space
  s = s .. "%*" -- Rehighlight group.

  s = s .. "%4*" -- Switch to User4 highlight group.
  s = s .. " " -- Space
  s = s .. "%{statusline#fileprefix()}" -- File path
  s = s .. "%*" -- Rehighlight group.
  s = s .. "%3*" -- Switch to User3 highlight group (bold).
  s = s .. "%{statusline#filename()}" -- File path
  s = s .. " " -- Space
  s = s .. "%*" -- Rehighlight group.

  s = s .. "%4*" -- Switch to User4 highlight group.
  s = s .. " " -- Space
  -- Needs to be all on one line:
  --   %(                   Start item group.
  --   [                    Left bracket (literal).
  --   %M                   Modified flag: ,+/,- (modified/unmodifiable) or nothing.
  --   %R                   Read-only flag: ,RO or nothing.
  --   %{statusline#ft()}   Filetype (not using %Y because I don't want caps).
  --   %{statusline#fenc()} File-encoding if not UTF-8.
  --   ]                    Right bracket (literal).
  --   %)                   End item group.
  s = s .. "%(%M%R%{statusline#ft()}%{statusline#fenc()}%)"
  s = s .. " " -- Space
  s = s .. "%*" -- Rehighlight group.
  s = s .. "%<" -- Truncation point, if not enough space

  s = s .. "%=" -- Align right

  s = s .. "%3*" -- Switch to User3 highlight group.
  s = s .. " " -- Space
  s = s .. "%<" -- Truncation point, if not enough space
  s = s .. "%{v:lua.MyFugitiveStatusline()}"
  s = s .. " " -- Space
  s = s .. "%*" -- Rehighlight group.

  s = s .. "%4*" -- Switch to User4 highlight group.
  s = s .. " " -- Space
  s = s .. "%{SleuthIndicator()}" -- Space settings
  s = s .. " " -- Space
  s = s .. "%l:%c/%L" -- Current line:Column number/total lines
  s = s .. " " -- Space
  s = s .. "%*" -- Rehighlight group.

  s = s .. "%3*" -- Switch to User3 highlight group.
  s = s .. " " -- Space
  s = s .. "%p" -- Percentage through buffer.
  s = s .. "%%" -- Literal %.
  s = s .. "%*" -- Rehighlight group.
  return s
end

vim.opt.statusline = statusline()

-- }}}

-- Abbreviations {{{
vim.cmd([[iabbrev @@    joaquin@chimeces.com]])
vim.cmd([[iabbrev wweb  http://chimeces.com]])
vim.cmd([[iabbrev ssig  <cr>Joaquin Oltra<cr>joaquin@chimeces.com<cr>]])

vim.cmd(
  [[iabbrev alice1 Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, `and what is the use of a book,' thought Alice `without pictures or conversation?'<cr>]]
)
vim.cmd(
  [[iabbrev alice2 So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.<cr>]]
)
vim.cmd(
  [[iabbrev alice3 There was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be late!' (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.<cr>]]
)
vim.cmd(
  [[iabbrev alice4 In another moment down went Alice after it, never once considering how in the world she was to get out again.<cr><cr>The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well.<cr>]]
)
vim.cmd(
  [[iabbrev alice5 Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-shelves; here and there she saw maps and pictures hung upon pegs. She took down a jar from one of the shelves as she passed; it was labelled `ORANGE MARMALADE', but to her great disappointment it was empty: she did not like to drop the jar for fear of killing somebody, so managed to put it into one of the cupboards as she fell past it.<cr>]]
)
vim.cmd(
  [[iabbrev alice6 <cr>There was a table set out under a tree in front of the house, and the March Hare and the Hatter were having tea at it: a Dormouse was sitting between them, fast asleep, and the other two were using it as a cushion, resting their elbows on it, and talking over its head. `Very uncomfortable for the Dormouse,' thought Alice; `only, as it's asleep, I suppose it doesn't mind.'<cr><cr>The table was a large one, but the three were all crowded together at one corner of it: `No room! No room!' they cried out when they saw Alice coming. `There's plenty of room!' said Alice indignantly, and she sat down in a large arm-chair at one end of the table.<cr>]]
)
vim.cmd(
  [[iabbrev alice7 <cr>The Hatter was the first to break the silence. `What day of the month is it?' he said, turning to Alice: he had taken his watch out of his pocket, and was looking at it uneasily, shaking it every now and then, and holding it to his ear.<cr><cr>Alice considered a little, and then said `The fourth.'<cr><cr>`Two days wrong!' sighed the Hatter. `I told you butter wouldn't suit the works!' he added looking angrily at the March Hare.<cr><cr>`It was the best butter,' the March Hare meekly replied.<cr><cr>`Yes, but some crumbs must have got in as well,' the Hatter grumbled: `you shouldn't have put it in with the bread-knife.'<cr><cr>The March Hare took the watch and looked at it gloomily: then he dipped it into his cup of tea, and looked at it again: but he could think of nothing better to say than his first remark, `It was the best butter, you know.'<cr>]]
)

vim.cmd([[iabbrev funciton function]])
vim.cmd([[iabbrev funcitons functions]])
-- }}}

-- Autocommands {{{
local joakin_autocmd = vim.api.nvim_create_augroup("joakin", { clear = true })

-- Remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    if vim.fn.line([['"]]) > 0 and vim.fn.line([['"]]) <= vim.fn.line("$") then
      vim.cmd([[normal! g`"zvzz]])
    end
  end,
})

-- Autoclose popups when exiting insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd([[silent! pclose]])
    end
  end,
})

-- Auto-reload file if changed on focus
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
  pattern = "*",
  group = joakin_autocmd,
  command = "checktime",
})

-- Make current window more obvious by turning off/adjusting some features
-- in non-current windows.
vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter", "WinEnter" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    if vim.fn["autocmds#should_cursorline"]() then
      vim.opt_local.cursorline = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    if vim.fn["autocmds#should_cursorline"]() then
      vim.opt_local.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "VimEnter", "WinEnter" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    vim.fn["autocmds#focus_statusline"]()
  end,
})
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    vim.fn["autocmds#blur_statusline"]()
  end,
})

-- Resize panes to a minimum size when shifting to them
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "VimEnter", "WinEnter" }, {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    vim.fn["autocmds#split_resize"]()
  end,
})

-- Settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})
vim.api.nvim_create_autocmd("TermEnter", {
  pattern = "*",
  group = joakin_autocmd,
  command = "startinsert!",
})
vim.api.nvim_create_autocmd("TermLeave", {
  pattern = "*",
  group = joakin_autocmd,
  command = "stopinsert!",
})

-- Make sure text soft wraps in the preview window, and don't show numbers
-- Unsure if this is actually used nowadays in my day to day
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    if vim.o.previewwindow then
      vim.opt_local.wrap = true
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end,
})

-- Highlight text when yanked
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = joakin_autocmd,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use foldmethod=marker when editing init.lua
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "init.lua",
  group = joakin_autocmd,
  callback = function()
    vim.opt_local.foldmethod = "marker"
  end,
})

-- }}}

-- Project settings {{{

-- Example of project settings {{{
-- From old .vimrc. Here in case useful as a reference in the future
-- augroup project_settings
--   autocmd!
--   autocmd BufNewFile,BufRead ~/dev/projects/wikimedia/* setlocal softtabstop=4 shiftwidth=4 tabstop=4
-- augroup END
--
-- Can also use (thanks to 'MarcWeber/vim-addon-local-vimrc'):
-- Put .vimrc in the folder of the project (or parent folders) with autocmds
-- too instead of settings here, like this:
-- project/.vimrc
-- augroup LOCAL_SETUP
--   " using vim-addon-sql providing alias aware SQL completion for .sql files and PHP:
--   autocmd BufRead,BufNewFile *.sql,*.php call vim_addon_sql#Connect('mysql',{'database':'DATABASE', 'user':'USER', 'password' : 'PASSWORD'})

--   " for php use tab as indentation character. Display a tab as 4 spaces:
--   " autocmd BufRead,BufNewFile *.php setlocal noexpandtab| setlocal tabstop=4 | setlocal sw=4
--   autocmd FileType php setlocal noexpandtab| setlocal tabstop=4 | setlocal sw=4

--   " hint: for indentation settings modelines can be an alternative as well as
--   " various plugins trying to set vim's indentation based on file contents.
-- augroup end
--
-- }}}
-- autocmd BufRead,BufNewFile */wikimedia/*.{js,php,css} call s:SetupWikimedia()
-- function s:SetupWikimedia()
--   setlocal noexpandtab tabstop=4 sw=0
-- endfunction
-- }}}
