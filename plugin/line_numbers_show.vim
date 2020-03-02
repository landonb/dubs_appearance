" Dubs Vim basic setting: show line numbers.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_line_numbers_show") || &cp
  finish
endif
let g:loaded_line_numbers_show = 1

" Show line numbers
" ------------------------------------------------------
set nu!

