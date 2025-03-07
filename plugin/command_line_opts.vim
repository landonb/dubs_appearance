" Dubs Vim command-line settings: wire Ctrl-c; set wildmenu.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_command_line_opts
endif

if exists('g:loaded_dubs_appearance_command_line_opts') || &cp

  finish
endif

let g:loaded_dubs_appearance_command_line_opts = 1

" -------------------------------------------------------------------

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Command-line settings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" SAVVY: Neovim defaults:
"   <C-C> works in |q:| command-line window (because mswin)
"   - <C-C> in command line itself dismisses it
"   &wildmenu = 1

" Command-line Copy
" --------------------------------
" mswin.vim maps Ctrl-c to copy (yank) in visual and select modes.
" Here we make it so Ctrl-C also works in the Command-line window.
" - Note the c_CTRL-Y is copy-to-clipboard. (Seems weird that Vim has a
"   copy-to-clipboard function, and it only works in the command window.)
cmap <C-C> <C-Y>

" Enable Vim Command-line Completion
" ------------------------------------------------------
" Can't remember a command's proper name?
" Hit <Tab> (!)
set wildmenu

