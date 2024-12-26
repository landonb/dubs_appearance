" Dubs Vim basic setting: disable visual bell.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_noticeable_cursor
endif

if exists('g:loaded_dubs_appearance_noticeable_cursor') || &cp

  finish
endif

let g:loaded_dubs_appearance_noticeable_cursor = 1

" -------------------------------------------------------------------

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
"       https://github.com/landonb/dubs_after_dark#🌃
"
"     Which uses gui=reverse so that the cursors are always
"     visible, e.g.,
"
"       highlight Cursor gui=reverse guifg=NONE guibg=NONE
"       highlight iCursor gui=reverse guifg=NONE guibg=NONE

set guicursor+=n-c-v:block-blinkon0-Cursor
set guicursor+=i:ver29-blinkon0-iCursor

