" Dubs Vim basic setting: disable visual bell.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_noticeable_cursor") || &cp
  finish
endif
let g:loaded_noticeable_cursor = 1

" REFER: :help guicursor
"
" - Disable blink.
"   - Something, or some plugin, causes cursor blink pattern to
"     reset once or more per second. So the blink is erratic and
"     distracting.
"
" - Use a slightly wider insert mode caret, so it's more noticeable
"   and findable.
"
" - CXREF: Set the cursor highlights accordingly, too.
"
"   - E.g., see dubs_after_dark colorscheme
"
"       https://github.com/landonb/dubs_after_dark
"
"     Which uses gui=reverse so that the cursors are always
"     visible, e.g.,
"
"       highlight Cursor gui=reverse guifg=NONE guibg=NONE
"       highlight iCursor gui=reverse guifg=NONE guibg=NONE

set guicursor+=n-c-v:block-blinkon0-Cursor
set guicursor+=i:ver29-blinkon0-iCursor

