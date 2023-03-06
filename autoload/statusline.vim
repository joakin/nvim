function! statusline#gutterpadding(subtractBufferNumber) abort
  let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth])
  let l:bufferNumberWidth=a:subtractBufferNumber ? strlen(winbufnr(0)) : 0
  let l:padding=repeat(' ', l:gutterWidth - l:bufferNumberWidth)
  return l:padding
endfunction

function! statusline#fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename == '' || l:basename == '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! statusline#filename() abort
  " set statusline+=\      " Space
  " set statusline+=%t     " Filename.
  let l:basename=expand('%:h')
  let l:space=''
  if l:basename == '' || l:basename == '.'
    let l:space = ' '
  endif
  return l:space . expand('%:t')
endfunction

function! statusline#ft() abort
  if strlen(&ft)
    return ',' . &ft
  else
    return ''
  endif
endfunction

function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction
