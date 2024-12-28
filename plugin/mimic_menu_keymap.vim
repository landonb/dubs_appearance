" Dubs Vim menu bar-inspired mappings.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_mimic_menu_keymap
endif

if exists('g:loaded_dubs_appearance_mimic_menu_keymap') || &cp

  finish
endif

let g:loaded_dubs_appearance_mimic_menu_keymap = 1

" -------------------------------------------------------------------

" HINT: If you want to show the menubar:
"   :set guioptions+=m  " show menu bar
" then to hide again:
"   :set guioptions-=m  " hide menu bar
" Or add these two lines to your fork of tpope's vim-unimpaired:
"   nmap <script> <Plug>(unimpaired-enable)m  :<C-U>set guioptions+=m<CR>
"   nmap <script> <Plug>(unimpaired-disable)m :<C-U>set guioptions-=m<CR>
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
  " - Note that an explict :Bdelete on bufhidden=delete file will
  "   error, e.g.:
  "     E516: No buffers were deleted: bdelete 30
  "   - So best to use bufhidden=wipe instead on
  "     those types of buffers.
  nnoremap <M-f>c :Bdelete<CR>
  inoremap <M-f>c <C-o>:Bdelete<CR>

  " --------------------------------
  " Clear the buffer list
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &File.Clos&e\ All.
  "
  nnoremap <M-f>e :only<CR>:enew<CR>:BufOnly<CR>
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
  nnoremap <M-f>l :wa<CR>
  inoremap <M-f>l <C-o>:wa<CR>

  " --------------------------------
  " Make a Window.New that splits Vertically (and loads empty buffer).
  " --------------------------------
  " Mimics Dubs Vim menu shortcut: &Window.New\ V-&Split
  "
  nnoremap <M-w>s <C-w>v<C-w>p:enew<CR>:setlocal bufhidden=wipe<CR><C-w>p
  inoremap <M-w>s <C-O><C-w>v<C-O><C-w>p<C-O>:enew \| setlocal bufhidden=wipe<CR><C-O><C-w>p
endfunction

" ------------------------------------------------------

" Map some common, familiar Linux/Windows <Alt-F> menu commands you'd
" find in most apps:
" - <Alt-f>n, <Alt-f>a, <Alt-f>x, and <Alt-f>q.
function! s:RecreateBuiltinMenuMappings_File()
  " Builtin file menu entries:
  "
  " &File.&Open → :e
  " &File.Open Tab... → :tabnew
  " &File.Spli&t-Open... → :sp
  " &File.&New → :enew
  " &File.&Close → :Bdelete
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
  nnoremap <M-f>n :enew<CR>
  inoremap <M-f>n <C-O>:enew<CR>
  " SAVVY: Author almost never creates a new file that they later save.
  " - I generally use new files just to empty out the window.
  "   - So hide new buffers when they're unloaded from a window,
  "     so you don't end up with a bunch on [No Name] buffers.
  "   - This also forces you to deal with the buffer if you made
  "     changes to it (e.g., so you give it a path and save it,
  "     or do something else with your changes).
  " - Note that we use :Bdelete to also cleanup buffers.
  "   - But Bdelete causes an error if bufhidden=delete, e.g.:
  "       E516: No buffers were deleted: bdelete 30
  "     Fortunately it works find if we use bufhidde=wipe.
  nnoremap <silent> <M-f>n :enew<CR>:setlocal bufhidden=wipe<CR>
  inoremap <silent> <M-f>n <C-O>:enew \| setlocal bufhidden=wipe<CR>

  " Replicate builtin <M-f>a Save <A>s....
  nnoremap <M-f>a :bro sav<CR>
  inoremap <M-f>a <C-O>:bro sav<CR>

  " Replicate builtin <M-f>x E<x>it.
  nnoremap <M-f>x :qa<CR>
  inoremap <M-f>x <C-O>:qa<CR>

  " Make up a combo-close-quite (so Session.vim obliterated).
  nnoremap <M-f>q :only<CR>:enew<CR>:BufOnly<CR>:qa<CR>
  inoremap <M-f>q <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR><C-O>:qa<CR>
endfunction

" SAVVY: Mimic some <C-w>{char} commands at <M-w>{char} in normal and insert modes.
" - Not any more convenient in normal mode, but obviates need to <Esc> or <C-o>
"   when in insert mode (where <C-w> in insert mode is delete back word).
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
  nnoremap <M-w>n <C-w>n
  inoremap <M-w>n <C-O><C-w>n

  " I remapped <M-w>s earlier, to open-new-buffer-in-new-vertical-split.

  " Replicate builtin <M-w>p S<p>lit [horizontally].
  nnoremap <M-w>p <C-w>s
  inoremap <M-w>p <C-O><C-w>s

  " I've never used <M-w>l, don't care.
  " - DUNNO/2024-12-13: What's this? &Window.Sp&lit To

  " Replicate builtin <M-w>v Split <V>ertically.
  nnoremap <M-w>v <C-w>v
  inoremap <M-w>v <C-O><C-w>v

  " I've never used <M-w>x, don't care.
  " - DUNNO/2024-12-13: What's this? &Window.Split File E&xplorer

  " Replicate builtin <M-w>c <C>lose.
  " - Close window is also mapped by mswin.vim to <C-F4>
  "   - Except that does nothing when author tries it
  "     (but the map exists).
  "   /Applications/MacVim.app/Contents/Resources/vim/runtime/mswin.vim
  nnoremap <M-w>c <C-w>c
  inoremap <M-w>c <C-O><C-w>c

  " Replicate builtin <M-w>o Close <O>ther(s) (aka 'make <O>nly window')
  nnoremap <M-w>o <C-w>o
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

