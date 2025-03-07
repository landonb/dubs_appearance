" Dubs Vim scroll window commands re-wiring.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------" 

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_scroll_window_fix
endif

if exists('g:loaded_dubs_appearance_scroll_window_fix') || &cp

  finish
endif

let g:loaded_dubs_appearance_scroll_window_fix = 1

" -------------------------------------------------------------------

" See `behave mswin` mappings:
"
"   vim/runtime/mswin.vim
"
" and related help on scroll window up and down commands:
"
"   :h CTRL-e
"   :h CTRL-y

" In normal mode, C-e scrolls the window down,
"             and C-y scrolls it up.
" In insert mode, C-e mirrors characters from the line below, one char at a time;
"             and C-y similarly mirrors the line above.
" - But when using mswin mappings, C-y is mapped to redo in both modes.
"   (And C-e is left alone.) [Ref: runtime/mswin.vim]
" Because most apps use <Ctrl-Z>/<Ctrl-Y> (or <Ctrl-Z>/<Shift-Ctrl-Z>)
" for undo/redo, I've never resolved to use (Neo)Vim's built-in bindings.
" - I also don't leave Insert mode as often as other Neovimmers, I assume,
"   as I've mapped dozens of Normal mode features to Insert mode.
" - And vim's default undo/redo only work from Normal mode.
"   - Also, curiously, there's a lack of parity: Undo has its own
"     pseudo-key, <Undo>, but there's no <Redo> (or did a keyboard
"     decades ago have an <Undo> key, but not a <Redo>?); you can press
"     a single lowercase key to undo, |u|, but to redo, it's a Ctrl-key
"     combo, |CTRL-R|; but at least there's a colon-command for each,
"     |:u[ndo] {N}| and |:red[o]|, though the latter does not accept a
"     number {N}.
" Considering that, and that I don't use the <Ctrl-e>/<Ctrl-y> Insert
" mode character-mirroring features, and that we already changed <C-y>
" via mswin, we'll take ownership of Insert mode <C-e> here.
" - Another way to view this: mswin breaks the parity:
"   - You can still C-e to scroll the window down in Normal mode, but C-y
"     no longer works; and you can still C-e to mirror characters in Insert
"     mode, but C-y no longer works.
" - Because I don't use the mirror feature, like I said, and because I like
"   the scroll behavior, let's map insert mode C-e to the same scroll behavior.
"   - Then we just need to map the opposite scroll behavior, which feels right
"     at home at the complementary Alt-key binding, i.e., Alt-e to scroll the
"     window up.
"     - Default <Alt-e> leaves Insert mode and runs |e| to move the cursor to
"       the end of the word.

function! s:FixupScrollWindowMappings()
  " Add scroll-up via Alt-e to complement Ctrl-e scroll-down.
  if has('macunix')
    " Note that macOS pauses to see if you're going to enter a character
    " to be accented, so this doesn't quite very elegantly (or well).
    " - SAVVY: But <Shift-Alt-E> works immediately.
    " - Same with <Alt-u> and <Alt-i> (and <Shift-Alt-u> and <Shift-Alt-i>).
    noremap ´ <C-y>
    inoremap ´ <C-o><C-y>
  else
    noremap <M-e> <C-y>
    inoremap <M-e> <C-o><C-y>
  endif
  " Add scroll-down to insert mode at Ctrl-e, to complement normal Ctrl-e,
  " and acknowledging this masks the second half of the mirror neighbor line
  " feature (that mswin.vim masked the other half of, C-y).
  inoremap <C-e> <C-o><C-e>
endfunction

call s:FixupScrollWindowMappings()

