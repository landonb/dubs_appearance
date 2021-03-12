" Vim, Of Course! Look 'n feel: Disable Insert mode Wait-on-Escape.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_no_wait_on_escape") || &cp
  finish
endif
let g:loaded_no_wait_on_escape = 1

" No Wait on Escape (from Insert Mode to Normal Mode)
" ---------------------------------------------------
" When run in a terminal, you might notice a delay when
" pressing Escape to exit Insert mode.
"
" This is because Vim is waiting for a potential escape key code,
" e.g., ^[o is the two-key sequence, <Escape>, then <o>.
"
" But these sequences are just convenience maps to the same Alt-key
" combinations, e.g., ^[o is the same as Alt-o.
"
" (lb): I have not seen a keyboard without an Alt key in a long while,
" and I exclusively use Alt-key combinations -- never Escape key code
" sequences -- so I'd prefer *not* waiting on Escape to enter Normal
" mode. I assume users of this plugin will appreciate this behavior,
" too.

" Note that you cannot just disable Escape key codes, e.g.:
"
"   set noesckeys
"
" because then arrow keys don't work -- e.g., pressing <Up> will
" insert 'A' on a new line above the cursor.

" So use the alternative approach, which is not to disable Escape key
" codes, but to make the delay really short, e.g., 100 msec:
"
" Vim defaults: set timeout timeoutlen=1000 ttimeoutlen=-1
"
set timeout timeoutlen=1000 ttimeoutlen=100

" With apprecation to:
"
"   https://vim.fandom.com/wiki/Mapping_fast_keycodes_in_terminal_Vim

