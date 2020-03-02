" Dubs Vim syntax enabler.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_syntax_enable_set") || &cp
  finish
endif
let g:loaded_syntax_enable_set = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Syntax enable
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable syntax highlighting
" ------------------------------------------------------
" This is enabled by default in Windows
" but not in Linux.
syntax enable

