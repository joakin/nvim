" Hemisu light setup
" set background=light
" colorscheme hemisu
" hi ColorColumn ctermbg=255

" set background=light
" set background=dark
" colorscheme PaperColor

" colorscheme gruvbox

" colorscheme solarized

" colorscheme spacegray

" hi Normal ctermbg=none
" hi NonText ctermbg=none
" hi ColorColumn ctermbg=none

" Setup with transparent background for the terminal
augroup vimrc
  autocmd!
  autocmd ColorScheme * call Highlights()
augroup END

function Highlights()
  if &background == 'dark'
    hi Normal ctermbg=none guibg=none
    hi LineNr ctermbg=none guibg=none
    hi NonText ctermbg=none guibg=none
    hi ColorColumn ctermbg=none guibg=none
    hi SignColumn ctermbg=none guibg=none
    hi VertSplit ctermbg=none guibg=none
    hi Folded ctermbg=234 ctermfg=59 guibg=#1c1c1c guifg=#5f5f5f
    hi StatusLine cterm=none ctermbg=none gui=none guibg=none
    hi StatusLineNC cterm=none ctermbg=232 ctermfg=239 gui=none guibg=#080808 guifg=#4e4e4e
    hi Comment ctermfg=240 guifg=#585858
    hi CursorLine ctermbg=233 guibg=#121212
    hi Visual cterm=none ctermbg=53 gui=none guibg=#5f005f
    " hi StatusLine ctermbg=none ctermfg=249
    " Normal         xxx ctermfg=250 guifg=#B3B8C4 guibg=#111314
    "

    " Errors in Red
    hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
    " Warnings in Yellow
    hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
    " Info and Hints in White
    hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
    hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White


    " for filetype
    hi link User1 StatusLine

    " for blurred statuslines
    hi link User2 MatchParen

    " Normal + bold (used for file names).
    hi link User3 Normal

    " StatusLineNC (used for path).
    hi link User4 StatusLineNC
  endif
endfunction

colorscheme gruvbox
