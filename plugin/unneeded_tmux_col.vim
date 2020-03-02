" Unneeded Dubs Vim tmux TrueColor settings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_unneeded_tmux_col") || &cp
  finish
endif
let g:loaded_unneeded_tmux_col = 1

" ------------------------------------------------------
" Vim True color in tmux
" ------------------------------------------------------

function s:DubsAppear_TrueColors()
  " (lb): This if-block suggested by:
  "   - How to use true colors in vim under tmux? #1246
  "     https://github.com/tmux/tmux/issues/1246
  "     'Enable true color 启用终端24位色'
  "   - Except I think my .tmux.conf.local is enough.
  "     - X-ref:
  "         set -g default-terminal 'xterm'
  "         set -as terminal-overrides ',xterm*:Tc'
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    " set term=screen-256color
    set term=xterm
  endif
endfunction

" ***

function! s:DubsAppearance_Main()
  " 2020-02-06: So, not necessary after all?
  " - Disabled for now, but leaving here while
  "   I start using latest tmux + vim and make
  "   sure everything works.
  "  call <SID>DubsAppear_TrueColors()
endfunction

" call <SID>DubsAppearance_Main()

