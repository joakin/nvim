" Try to enforce encoding used later on the file. Fixes github.com/vim/vim/issues/3668
scriptencoding utf-8

" OS detection vars

let g:isMac = 0
if has('macunix')
  let g:isMac = 1
endif
let g:isWindows = 0
if has('win32')
  let g:isWindows = 1
endif
let g:isLinux = 0
if has('unix')
  let g:isLinux = 1
endif
let g:isWSL = 0
if g:isLinux && executable('wslview')
  let g:isWSL = 1
endif

lua require("init")

" Autocommands {{{
if has('autocmd')

  augroup joakin_autocommands

    autocmd!

    " Make sure text soft wraps in the preview window, and don't show numbers
    autocmd WinEnter * if &previewwindow | setlocal wrap nonu nornu | endif

    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END

endif
" }}}

" Project settings {{{
if has('autocmd')

  " Example of project settings {{{
  " augroup project_settings
  "   autocmd!
  "   autocmd BufNewFile,BufRead ~/dev/projects/wikimedia/* setlocal softtabstop=4 shiftwidth=4 tabstop=4
  " augroup END
  "
  " Can also use (thanks to 'MarcWeber/vim-addon-local-vimrc'):
  " Put .vimrc in the folder of the project (or parent folders) with autocmds
  " too instead of settings here, like this:
  " project/.vimrc
  " augroup LOCAL_SETUP
    " " using vim-addon-sql providing alias aware SQL completion for .sql files and PHP:
    " autocmd BufRead,BufNewFile *.sql,*.php call vim_addon_sql#Connect('mysql',{'database':'DATABASE', 'user':'USER', 'password' : 'PASSWORD'})

    " " for php use tab as indentation character. Display a tab as 4 spaces:
    " " autocmd BufRead,BufNewFile *.php setlocal noexpandtab| setlocal tabstop=4 | setlocal sw=4
    " autocmd FileType php setlocal noexpandtab| setlocal tabstop=4 | setlocal sw=4

    " " hint: for indentation settings modelines can be an alternative as well as
    " " various plugins trying to set vim's indentation based on file contents.
  " augroup end
  "
  " }}}
  " autocmd BufRead,BufNewFile */wikimedia/*.{js,php,css} call s:SetupWikimedia()
  " function s:SetupWikimedia()
  "   setlocal noexpandtab tabstop=4 sw=0
  " endfunction
endif
" }}}
