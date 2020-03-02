" Dubs Vim basic setting: set linebreak.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_line_break_smarts") || &cp
  finish
endif
let g:loaded_line_break_smarts = 1

" Break lines on word boundaries
" ------------------------------------------------------
" Set linebreak, which complements wrap by wrapping lines
" only where visually pleasing, i.e., at the nearest
" whitespace character or punctuation.
" Specifically, :set breakat? returns
"
"    breakat= ^I!@*-+;:,./?
set linebreak

