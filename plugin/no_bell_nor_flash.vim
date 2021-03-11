" Dubs Vim basic setting: disable visual bell.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_no_beep_nor_flash") || &cp
  finish
endif
let g:loaded_no_beep_nor_flash = 1

" All Quiet on the Vimmer Front
" ------------------------------------------------------
" Per :help visualbell, 'When no beep or flash is wanted, use: set vb t_vb='
"
" Which uses a visual bell instead of beeping, but then disables the visual
" bell using its terminal option, t_vb.
"
" Note that Vim sets t_vb when the GUI starts -- e.g., to ^[|f -- which is
" after plugins are sourced. So use an event callback to disable it after.
"
" Also, errorbells is disabled for completeness, though already disabled.
"
" With thanks to:
"
"   https://vim.fandom.com/wiki/Disable_beeping

" Disable errorbells (noeb), enable visualbell (vb), but make it doing nothing (t_vb).
set noeb vb t_vb=
augroup no_bell_nor_flash
  au!
  autocmd GUIEnter * set vb t_vb=
augroup END

