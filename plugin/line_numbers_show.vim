" Dubs Vim basic setting: show line numbers.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_line_numbers_show
endif

if exists('g:loaded_dubs_appearance_line_numbers_show') || &cp

  finish
endif

let g:loaded_dubs_appearance_line_numbers_show = 1

" -------------------------------------------------------------------

" Show line numbers
" ------------------------------------------------------
set nu!

" Show relative line numbers, too.
" - This hurts my brain:
"     set nu rnu

