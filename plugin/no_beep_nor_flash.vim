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
" Per :help visual bell, 'When no beep or flash is wanted, use:'
set vb t_vb=
" Where t_vb is the visual bell terminal option,
" which is set to nothing (disabled).

