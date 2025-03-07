" Dubs Vim not setting mousehide option.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_mousehide_not_set
endif

if exists('g:loaded_dubs_appearance_mousehide_not_set') || &cp

  finish
endif

let g:loaded_dubs_appearance_mousehide_not_set = 1

" -------------------------------------------------------------------

" SAVVY: Neovim defaults:
"   &mousehide = 1

function! s:ThemeResetMouse()
  if !has("gui_running") | return | endif
  " Hide the mouse pointer while typing.
  " ISOFF: This does not hide the mouse in Windows gVim,
  " nor in Neovide, and it's enabled by default, anyway
  " (but leave this file/comment for reference).
  "
  "  set mousehide
endfunction

" call s:ThemeResetMouse()

