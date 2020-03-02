" Dubs Vim initial GUI dimensions and placement.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_init_gui_win_size") || &cp
  finish
endif
let g:loaded_init_gui_win_size = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Start up window size
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" FIXME/2020-03-02 00:00: This should probably be in my private plugin,
" and it should set different values depending on the host (because,
" e.g., one machine has two monitors, and main monitor's upper-left x,y
" is far from 0,0 -- so these values are hardly universal.

" Start Big
" ------------------------------------------------------
" Start with a reasonably sized window for GUIs
" (ignore for CLI so we don't change terminal size)
if has("gui_running")
  " winpos 100 100
  " set columns=111 lines=44
  " 2010.06.24 Work config:
  " FIXME Home config; if 'fa', winpos 0 0 ?
  winpos 718 0
  set columns=121 lines=68
endif
" NOTE To start maximized:
"      au GUIEnter * simalt ~x

