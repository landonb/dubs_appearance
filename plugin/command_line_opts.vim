" Dubs Vim command-line settings: wire Ctrl-c; set wildmenu.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_command_line_opts") || &cp
  finish
endif
let g:loaded_command_line_opts = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Command-line settings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Command-line Copy
" --------------------------------
" mswin.vim maps Ctrl-c to copy (yank) in visual and select modes.
" Here we make it so Ctrl-C also works in the Command-line window.
cmap <C-C> <C-Y>

" Enable Vim Command-line Completion
" ------------------------------------------------------
" Can't remember a command's proper name?
" Hit <Tab> (!)
set wildmenu

