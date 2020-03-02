" Dubs Vim not setting mousehide option.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_mousehide_not_set") || &cp
  finish
endif
let g:loaded_mousehide_not_set = 1

function! s:ThemeResetMouse()
  if !has("gui_running") | return | endif
  " Hide the mouse pointer while typing
  " NOTE This does not hide the mouse in
  "      Windows gVim, so it's off! for now
  "set mousehide
endfunction

" call s:ThemeResetMouse()

