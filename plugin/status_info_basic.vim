" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Dubs Vim default status info (line number, etc.) when no dubs_mescaline.

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_status_info_basic
endif

if exists('g:loaded_dubs_appearance_status_info_basic') || &cp

  finish
endif

let g:loaded_dubs_appearance_status_info_basic = 1

" -------------------------------------------------------------------

" SAVVY: Neovim defaults:
"   &laststatus = 2  -- each window has its own statusline
"   &ruler = 1
" - LazyVim: via lua/lazyvim/config/options.lua
"   vim.opt.laststatus = 3  -- single, global statusline
"   vim.opt.ruler = false
" - Note that &ruler does nothing if you use a custom &statusline.
" - And if you set laststatus = 3, then a row of "─" highlighted by
"   WinSeparator is used in place of the statusline.

" Always show a status line (show line and column numbers; see also: ruler)
" ------------------------------------------------------
" 2017-12-09: See also dubs_mescaline
"   github.com/landonb/dubs_mescaline
au VimEnter * set laststatus=2

" 2017-06-13: I could swear this... wait, da what?
"   Now the ruler is working again!
"   Nonetheless, I don't remember having needed to
"   enabled this, but just in case this happens again,
"   it's da `ruler` you want:
" 2017-08-01: It happened again. Or it's been happening
"   but I didn't notice, because I haven't needed/looked
"   for the ruler (row numbers, specifically) in a while.
"   So now it's reenabled. I'm wondering if this just pissed
"   me off somehow and I disabled it... to the git log!
set ruler

