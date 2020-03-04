" Dubs Vim menu bar-inspired mappings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_mimic_menu_keymap") || &cp
  finish
endif
let g:loaded_mimic_menu_keymap = 1

" ------------------------------------------------------

" HINT: If you want to show the menubar:
"   :set guioptions+=m  " show menu bar
" then to hide again:
"   :set guioptions-=m  " hide menu bar
" Or add these two lines to your fork of tpope's vim-unimpaired:
"   call s:map('n', '[om', ':set guioptions+=m<CR>')
"   call s:map('n', ']om', ':set guioptions-=m<CR>')
" and then type [om and ]om from normal mode.

" ------------------------------------------------------

" Recreate (especially for insert mode) useful key mappings inspired
" by the menu bar (as configured first by Vim, in vim/runtime/menu.vim,
" and then by Dubs, in modify_menu_items.vim, but also subsequently
" hidden, because not needed to be seen or moused, but I'd still some
" of its key mappings wired.

function! s:RecreateDubsVimMappings()
  " With comments and comment-headers as found in
  "   modify_menu_items.vim

  " --------------------------------
  " A Close is a close is a close
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &File.&Close.
  "
  nnoremap <M-f>c :Bclose<CR>
  inoremap <M-f>c <C-o>:Bclose<CR>

  " --------------------------------
  " Clear the buffer list
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &File.Clos&e\ All.
  "
  " FIXME/2020-03-02: COUPLING:
  "   dubs_buffer_fun/plugin/BufOnly.vim
  noremap <M-f>e :only<CR>:enew<CR>:BufOnly<CR>
  inoremap <M-f>e <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR>

  " ------------------------------------------
  " Re-map Split Open, Before Mapping Save All
  " ------------------------------------------
  " Mimics Dubs Vim menu shortcut: &File.Spli&t-Open\.\.\.
  "
  " I never used this shortcut, <Alt-f>t.
  " It calls :browse sp, which opens an OS file dialog, and then
  " it opens the user-selected file in a new Vim window pane.

  " --------------------------------
  " Simple Save All
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &File.Save\ A&ll.
  "
  noremap <M-f>l :wa<CR>
  inoremap <M-f>l <C-o>:wa<CR>

  " --------------------------------
  " Make a Window.New that splits Vertically (and loads empty buffer).
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &Window.New\ V-&Split
  "
  noremap <M-w>s <C-w>v<C-w>p:enew<CR><C-w>p
  inoremap <M-w>s <C-O><C-w>v<C-O><C-w>p<C-O>:enew<CR><C-O><C-w>p
endfunction

" ------------------------------------------------------

function! s:RecreateBuiltinMenuMappings_File()
  " Builtin file menu entries:
  "
  " &File.&Open → :e
  " &File.Open Tab... → :tabnew
  " &File.Spli&t-Open... → :sp
  " &File.&New → :enew
  " &File.&Close → :Bclose
  " &File.Clos&e All
  "
  " &File.&Save → :w
  " &File.Save &As... → :sav  [magic missing: the :browser file dialog!]
  " &File.Save A&ll → :wa
  "
  " &File.Split &Diff With...
  " &File.Split Patched &By...
  "
  " &File.&Print
  "
  " &File.Sa&ve-Exit → :wqa
  " &File.E&xit → :qa

  " Replicate builtin <M-f>n <N>ew File.
  noremap <M-f>n :enew<CR>
  inoremap <M-f>n <C-O>:enew<CR>

  " Replicate builtin <M-f>a Save <A>s....
  noremap <M-f>a :bro sav<CR>
  inoremap <M-f>a <C-O>:bro sav<CR>

  " Replicate builtin <M-f>x E<x>it.
  noremap <M-f>x :qa<CR>
  inoremap <M-f>x <C-O>:qa<CR>

  " Make up a combo-close-quite (so Session.vim obliterated).
  " FIXME/2020-03-02: COUPLING:
  "   dubs_buffer_fun/plugin/BufOnly.vim
  noremap <M-f>q :only<CR>:enew<CR>:BufOnly<CR>:qa<CR>
  inoremap <M-f>q <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR><C-O>:qa<CR>
endfunction

function! s:RecreateBuiltinMenuMappings_Window()
  " Builtin window menu entries:
  "
  " &Window.&New → ^Wn
  " &Window.New V-&Split → ^Ws
  " &Window.S&plit → ^Ws
  " &Window.Sp&lit To # → ^W^^
  " &Window.Split &Vertically → ^Wv
  " &Window.Split File E&xplorer
  "
  " &Window.&Close → ^Wc
  " &Window.Close &Other(s) → ^Wo
  "
  " &Window.Move &To → >
  " &Window.Rotate &Up → ^WR
  " &Window.Rotate &Down → ^Wr
  "
  " &Window.&Equal Size → ^W=
  " &Window.&Max Height → ^W_
  " &Window.M&in Height → ^W1_
  " &Window.Max &Width → ^W|
  " &Window.Min Widt&h → ^W1|

  " Replicate builtin <M-w>n <N>ew.
  " - I don't ever use this mapping but I might,
  "   it's like <C-w>p but opens new buffer, not
  "   same as split-from window pane; so kinda like
  "   my <M-w>s map that opens a new buffer in a new
  "   window.
  noremap <M-w>n <C-w>n
  inoremap <M-w>n <C-O><C-w>n

  " I remapped <M-w>s earlier, to open-new-buffer-in-new-vertical-split.

  " Replicate builtin <M-w>p S<p>lit [horizontally].
  noremap <M-w>p <C-w>s
  inoremap <M-w>p <C-O><C-w>s

  " I've never used <M-w>l, don't care.

  " Replicate builtin <M-w>v Split <V>ertically.
  noremap <M-w>v <C-w>v
  inoremap <M-w>v <C-O><C-w>v

  " I've never used <M-w>x, don't care.

  " Replicate builtin <M-w>c <C>lose.
  " (Also mapped by mswin.vim to <C-F4>.)
  noremap <M-w>c <C-w>c
  inoremap <M-w>c <C-O><C-w>c

  " Replicate builtin <M-w>o Close <O>ther(s) (aka "make <O>nly window")
  noremap <M-w>o <C-w>o
  inoremap <M-w>o <C-O><C-w>o

  " The remaining Window menu commands (see list above) involve moving
  " windows and resizing windows, which you already know how to do using
  " the builtins. (And generally I use the project tray toggle trick to
  " have the windows sized how I like.)
endfunction

function! s:RecreateBramVimMappings()
  " Of builtin menu mappings found in
  "   vim/runtime/menu.vim

  " &File.xxx [I use some of these shortcuts frequently; will recreate]
  " &Edit.xxx [lots of items; none I care about]
  " &Tools.xxx [don't think I've ever used]
  " &Syntax.xxx [never used]
  " &Buffers.xxx [can't say I've used; lists all buffers so you can
  "               select one to open, but I use __ command for that]
  " &Window.xxx [I use some of these shortcuts frequently; will remap]
  " &Plugin.xxx [if I hadn't just looked, wouldn't have known this existed]
  " &Help.xxx [I don't even check the version dialog this way, I use :ver]

  call s:RecreateBuiltinMenuMappings_File()
  call s:RecreateBuiltinMenuMappings_Window()
endfunction

" ------------------------------------------------------

function! s:MimicUsefulGuiMenuShortcutKeyMappings()
  call s:RecreateDubsVimMappings()
  call s:RecreateBramVimMappings()
endfunction

call s:MimicUsefulGuiMenuShortcutKeyMappings()

