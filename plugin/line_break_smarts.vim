" Dubs Vim basic setting: set linebreak.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_line_break_smarts
endif

if exists('g:loaded_dubs_appearance_line_break_smarts') || &cp

  finish
endif

let g:loaded_dubs_appearance_line_break_smarts = 1

" -------------------------------------------------------------------

" Break lines on word boundaries
" ------------------------------------------------------
" Set linebreak, which complements wrap by wrapping lines
" only where visually pleasing, i.e., at the nearest
" whitespace character or punctuation.
" Specifically, :set breakat? returns
"
"    breakat= ^I!@*-+;:,./?
set linebreak

