-- Init {{{
local isMac = 0
if vim.fn.has("macunix") == 1 then
  isMac = 1
end
local isWindows = 0
if vim.fn.has("win32") == 1 then
  isWindows = 1
end
local isLinux = 0
if vim.fn.has("unix") == 1 then
  isLinux = 1
end
local isWSL = 0
if isLinux and vim.fn.executable("wslview") then
  isWSL = 1
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
  -- LSP servers
  "neovim/nvim-lspconfig",
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Snippets
  "L3MON4D3/LuaSnip", -- Need a snippet engine for nvim-cmp

  -- Autocompletion
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  -- }}}

  -- Basics {{{
  -- Enable repeat for plugins that support it
  "tpope/vim-repeat",
  -- Fix some netrw ( - for up dir, . or ! for cmd with file, cg/cl to cd/lcd, ~ )
  "tpope/vim-vinegar",
  -- File/Buffer/Tag finder
  {
    "junegunn/fzf.vim",
    dependencies = {
      {
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },
    },
  },
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
  "chikamichi/mediawiki.vim",
  "tikhomirov/vim-glsl",
  "cespare/vim-toml",
  "briancollins/vim-jst",
  -- }}}

  -- Languages {{{

  -- Go {{{
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  -- }}}

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

  -- Clojure {{{
  -- Language and repl integration
  "tpope/vim-fireplace",
  -- Clojure syntax files
  "guns/vim-clojure-static",
  "kien/rainbow_parentheses.vim",
  -- }}}

  -- CSS {{{
  "1995eaton/vim-better-css-completion",
  "groenewege/vim-less",
  "cakebaker/scss-syntax.vim",
  "wavded/vim-stylus",
  -- }}}

  -- PHP {{{
  -- Syntax
  "StanAngeloff/php.vim",
  -- Better fold expressions
  "swekaj/php-foldexpr.vim",
  -- }}}

  -- Rust {{{
  -- Language files
  "rust-lang/rust.vim",
  -- }}}

  -- GraphQL {{{
  "jparise/vim-graphql",
  -- }}}
  -- }}}

  -- External tools {{{
  -- Search with :Ack (using ag)
  "mileszs/ack.vim",
  -- Git commands
  "tpope/vim-fugitive", -- Gcommit, Gstatus, Gdiff, etc.
  "junegunn/gv.vim", -- GV(!?)
  "tpope/vim-rhubarb", -- Support github for Gbrowse
  -- Unix commands (Delete, Remove, Move, Chmod, Mkdir, Find, Locate, Wall, SudoWrite, SudoEdit)
  "tpope/vim-eunuch",
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
  "morhetz/gruvbox",
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

local directory = "~/.vimswap/"
vim.opt.directory = directory
local undodir = "~/.vimundo/"
vim.opt.undodir = undodir
-- Make those folders automatically if they don't already exist.
if vim.fn.isdirectory(vim.fn.expand(undodir)) == 0 then
  vim.fn.mkdir(vim.fn.expand(undodir), "p")
end
if vim.fn.isdirectory(vim.fn.expand(directory)) == 0 then
  vim.fn.mkdir(vim.fn.expand(directory), "p")
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

  vim.opt.guioptions = { "c" }
  vim.opt.guioptions:remove({ "T" })
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
vim.opt.pumblend = 30

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

-- FZF {{{
-- augroup FZF
--   autocmd! FileType fzf
--   autocmd FileType fzf setlocal laststatus=0 noshowmode noruler
--     \| autocmd BufLeave <buffer> setlocal laststatus=2 showmode ruler
--   autocmd FileType fzf tnoremap <buffer> <Esc> <c-q>
-- augroup END
local fzf_autocmd = vim.api.nvim_create_augroup("FZF", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  group = fzf_autocmd,
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.showmode = false
    vim.opt_local.ruler = false
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = 0,
      callback = function()
        vim.opt_local.laststatus = 2
        vim.opt_local.showmode = true
        vim.opt_local.ruler = true
      end,
    })
    vim.keymap.set("t", "<Esc>", "<c-q>", { buffer = true, desc = "Exit" })
  end,
})

-- }}}

-- Rainbow parenthesis {{{
vim.g.rbpt_colorpairs = {
  { "13", "#6c71c4" },
  { "5", "#d33682" },
  { "1", "#dc322f" },
  { "9", "#cb4b16" },
  { "3", "#b58900" },
  { "2", "#859900" },
  { "4", "#268bd2" },
  { "6", "#2aa198" },
}
-- }}}

-- Ack (Ag) {{{
if vim.fn.executable("ag") == 1 then
  vim.g.ackprg = "ag --vimgrep"
  vim.opt.grepprg = "ag --nogroup --nocolor --ignore-case --column"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
-- }}}

-- NVIM LSP {{{
require("plugins/luasnip")
require("plugins/cmp")
require("config/lsp")
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
