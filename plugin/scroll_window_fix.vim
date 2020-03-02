" Dubs Vim scroll window commands re-wiring.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_scroll_window_fix") || &cp
  finish
endif
let g:loaded_scroll_window_fix = 1

" See `behave mswin` mappings:
"
"   vim/runtime/mswin.vim
"
" and related help on scroll window up and down commands:
"
"   :h CTRL-e
"   :h CTRL-y

" In normal mode, C-e scrolls the window down, and C-y scrolls it up.
" In insert mode, C-e mirrors the characters from the line below,
" one character at a time; and C-y similarly mirrors the line above.
" - But when using mswin mappings, C-y is mapped to redo in both modes.
"   (And C-e is left alone.) [Ref: runtime/mswin.vim]
" I am used to using the Ctrl-y mapping, and also I enjoy having a mapping
" from insert mode (the normal undo builtins and Ctrl-r and u, which only
" work from normal mode). I also don't use the builtin C-y mirror feature,
" so I'm fine continuing to use Ctrl-y for undo (and masking the builtin).
" - But it seems weird that C-e still implements have of the original features,
"   e.g., you can still C-e to scroll the window down in normal mode, but C-y
"   no longer works; and you can still C-e to mirror characters in insert mode,
"   but C-y no longer works.
"   - Because I don't use the mirror feature, like I said, and because I like
"     the scroll behavior, let's map insert mode C-e to the same scroll behavior.
"     - Then we just need to map the opposite scroll behavior, which feels right
"       at home at the complementary Alt-key binding, i.e., Alt-e to scroll the
"       window up.

function! s:FixupScrollWindowMappings()
  " Add scroll-up via Alt-e to complement Ctrl-e scroll-down.
  noremap <M-e> <C-y>
  inoremap <M-e> <C-o><C-y>
  " Add scroll-down to insert mode at Ctrl-e, to complement normal Ctrl-e,
  " and acknowledging this masks the second half of the mirror neighbor line
  " feature (that mswin.vim masked the other half of, C-y).
  inoremap <C-e> <C-o><C-e>
endfunction

call s:FixupScrollWindowMappings()

