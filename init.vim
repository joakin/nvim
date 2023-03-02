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

" Abbreviations {{{
iabbrev @@    joaquin@chimeces.com
iabbrev wweb  http://chimeces.com
iabbrev ssig  <cr>Joaquin Oltra<cr>joaquin@chimeces.com<cr>

iabbrev alice1 Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, `and what is the use of a book,' thought Alice `without pictures or conversation?'<cr>
iabbrev alice2 So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.<cr>
iabbrev alice3 There was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be late!' (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.<cr>
iabbrev alice4 In another moment down went Alice after it, never once considering how in the world she was to get out again.<cr><cr>The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well.<cr>
iabbrev alice5 Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-shelves; here and there she saw maps and pictures hung upon pegs. She took down a jar from one of the shelves as she passed; it was labelled `ORANGE MARMALADE', but to her great disappointment it was empty: she did not like to drop the jar for fear of killing somebody, so managed to put it into one of the cupboards as she fell past it.<cr>
iabbrev alice6 <cr>There was a table set out under a tree in front of the house, and the March Hare and the Hatter were having tea at it: a Dormouse was sitting between them, fast asleep, and the other two were using it as a cushion, resting their elbows on it, and talking over its head. `Very uncomfortable for the Dormouse,' thought Alice; `only, as it's asleep, I suppose it doesn't mind.'<cr><cr>The table was a large one, but the three were all crowded together at one corner of it: `No room! No room!' they cried out when they saw Alice coming. `There's plenty of room!' said Alice indignantly, and she sat down in a large arm-chair at one end of the table.<cr>
iabbrev alice7 <cr>The Hatter was the first to break the silence. `What day of the month is it?' he said, turning to Alice: he had taken his watch out of his pocket, and was looking at it uneasily, shaking it every now and then, and holding it to his ear.<cr><cr>Alice considered a little, and then said `The fourth.'<cr><cr>`Two days wrong!' sighed the Hatter. `I told you butter wouldn't suit the works!' he added looking angrily at the March Hare.<cr><cr>`It was the best butter,' the March Hare meekly replied.<cr><cr>`Yes, but some crumbs must have got in as well,' the Hatter grumbled: `you shouldn't have put it in with the bread-knife.'<cr><cr>The March Hare took the watch and looked at it gloomily: then he dipped it into his cup of tea, and looked at it again: but he could think of nothing better to say than his first remark, `It was the best butter, you know.'<cr>

iabbrev funciton function
iabbrev funcitons functions
" }}}

" Autocommands {{{
if has('autocmd')

  augroup joakin_autocommands

    autocmd!

    " Remember last cursor position
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line ("'\"") <= line("$") |
          \   exe "normal! g`\"zvzz"                        |
          \ endif

    " Autoclose popups
    autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

    " Checktime on focus
    autocmd WinEnter,FocusGained,BufEnter * :checktime

    " Make current window more obvious by turning off/adjusting some features
    " in non-current windows.
    autocmd InsertLeave,VimEnter,WinEnter * if autocmds#should_cursorline() | setlocal cursorline | endif
    autocmd InsertEnter,WinLeave * if autocmds#should_cursorline() | setlocal nocursorline | endif
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_statusline()
    autocmd FocusLost,WinLeave * call autocmds#blur_statusline()

    autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#split_resize()

    function! TerminalOptions()
      setlocal nonumber norelativenumber | startinsert
      silent au BufEnter <buffer> startinsert!
      silent au BufLeave <buffer> stopinsert!
    endfunction
    autocmd TermOpen * call TerminalOptions()

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
