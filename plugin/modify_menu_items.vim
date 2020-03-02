" Dubs Vim menu bar tweaks (change mappings; add and alter commands).
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_modify_menu_items") || &cp
  finish
endif
let g:loaded_modify_menu_items = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Application Menus
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ------------------------------------------------------
"  EditPlus-inspired File Command Mappings
" ------------------------------------------------------

" 'It doesn't suck,' says BBEdit. Which I
" started using sometime in the 90s. Then
" I graduated college, and some corporation
" sent monies my way to program on Windows.
" So I found EditPlus, which is the most
" baddest-ass Windows GUI editor ever. No
" Intellisence for me, thank you very much!
" Just file and project browsing, and regex
" searching to boot. And lots of nice keyboard
" shortcuts. Some of which we mock herein. Who
" doesn't have <M-f>e seared into their brain?

" Change gVim application menu key mappings
" -----------------------------------------

" Ctrl-W and Ctrl-Q are GUI editor favorites.
" But in gVim on Windows, <C-q> remaps what
" <C-v> was (which is "start Visual mode
" blockwise", so that <C-v> can be used for
" paste), and <C-w> is the start of all Window
" commands (and if you touch that, an angry
" mob of puritan Vimmers will come find you).
" So instead, get used to Alt-F commands, i.e.,
" the File menu.

function! s:GuiReconfigureMenu()
  " The menu is created and populated
  "   $VIMRUNTIME/menu.vim
  if !has("menu") || !has("gui_running") | return | endif

  " --------------------------------
  " A Close is a close is a close
  " --------------------------------
  " ... No, I mean *REALLY* close it. Don't just
  " hide the dang buffer -- pop it from the list.
  " And show the last buffer we were on.
  "
  " menu.vim's File.Close calls :close, which
  " closes the current window (or hides the
  " active buffer if there's only one window left
  " (and by hide I mean :enew is called to start
  " a new buffer)). So it's not actually closing
  " the file, it's closing the window or making a
  " new buffer. I'm not sure why this is mapped
  " to the File menu... so let's change it and
  " make File.Close really close (i.e., release)
  " the current file buffer. Do any or you Vimmer
  " traditionalists have a problem with that? =)
  " (Also -- redundantly -- the :close command
  "  is mapped to Window.Close, aka <Alt-W>c,
  "  or <Ctrl-W>c.)
  " NOTE 10.330 is File.Close, and 10.335 is
  "      File.-SEP1-
  "      i.e., from menu.vim:
  "   an <silent> 10.330 &File.&Close<Tab>:close
  "     \ :if winheight(2) < 0 <Bar>
  "     \   confirm enew <Bar>
  "     \ else <Bar>
  "     \   confirm close <Bar>
  "     \ endif<CR>
  " 'Un'-menu the existing menu item
  aunmenu File.Close
  " Use :an rather than :menu to apply to all modes.
  an 10.330 &File.&Close<Tab>:Bclose :Bclose<CR>
  " Thanks for :Bclose, Joe! (See: newbufdel.vim)
  "   http://vim.wikia.com/wiki/VimTip165

  " --------------------------------
  " Clear the buffer list
  " --------------------------------
  " <Alt-f>e ==> Close all files. This isn't
  " like <Alt-f>x, which quits and preserves your
  " workspace for the next time you run gVim.
  " This command literally deletes all your
  " buffers and starts a new one for you.
  " TODO This is broken if you <Alt-f>c some
  "      files and then quit -- the closed
  "      buffers are reopened. I think this is
  "      probably got to do with what's in
  "      Session.vim -- but even if I <Alt-f>c
  "      one buffer, then modify another buffer,
  "      save it, and quit- on restart, the
  "      buffer I closed is reopened (meaning,
  "      Session.vim was rewrit but still
  "      contains the closed buffers). This also
  "      has to do w/ Vim hidden buffers, which I
  "      don't completely get yet -- if you close
  "      a buffer and remove it from your buffer
  "      list, why is it just hidden and not
  "      really gone? Does this have to do with
  "      tags that are set, or something?
  " NOTE To work-around this, you have to <Alt-
  "      f>e to close all buffers, and then you
  "      have to <Alt-f>x to quit -- I've got it
  "      so if there's only the one empty buffer
  "      open when you quit, then Session.vim is
  "      deleted. Then, when you re-run Vim, none
  "      of those closed buffers are re-opened.
  nmenu 10.331 &File.Clos&e\ All
    \ :only<CR>:enew<CR>:BufOnly<CR>
  imenu 10.331 &File.Clos&e\ All
    \ <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR>
  cmenu 10.331 &File.Clos&e\ All
    \ <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR>
  omenu 10.331 &File.Clos&e\ All
    \ <C-O>:only<CR><C-O>:enew<CR><C-O>:BufOnly<CR>
  " Thanks for :BufOnly, CJR!
  "   http://www.vim.org/scripts/script.php?script_id=1071

  " ------------------------------------------
  " Re-map Split Open, Before Mapping Save All
  " ------------------------------------------

  " Re-map the split command, which uses the
  " same <Alt-f>l shortcut, i.e., from menu.vim:
  "   an 10.320 &File.Sp&lit-Open\.\.\.<Tab>:sp
  "     \ :browse sp<CR>
  aunmenu File.Split-Open\.\.\.
  an 10.320 &File.Spli&t-Open\.\.\.<Tab>:sp
    \ :browse sp<CR>

  " --------------------------------
  " Simple Save All
  " --------------------------------
  " <Alt-f>l ==> Save All
  "      :wa (save all buffers)
  "   or :xa (save-all-and-bidy-bye!)
  "      ZZ is also a nice way to save/close
  "         current buffer/window
  " NOTE 10.350 is File.Save; 10.400 is
  "      File.-SEP2-

  " Make Save All the new <Alt-f>l
  an 10.350 &File.Save\ A&ll<Tab>:wa :wa<CR>

  " --------------------------------
  " Make a Window.New that splits Vertically
  " --------------------------------
  " <Ctrl-W>n (also mapped to menu <Alt-w>n)
  " opens a new window above the current one
  " with an empty buffer. We want to do the
  " same, but for a vertically-split window,
  " i.e., open a new buffer in a new window
  " to the right of the current window.
  "an 70.300 &Window.&New<Tab>^Wn			<C-W>n
  nmenu 70.301 &Window.New\ V-&Split<Tab>^Ws
    \ <C-w>v<C-w>p:enew<CR><C-w>p
  imenu 70.301 &Window.New\ V-&Split<Tab>^Ws
    \ <C-O><C-w>v<C-O><C-w>p<C-O>:enew<CR><C-O><C-w>p
  cmenu 70.301 &Window.New\ V-&Split<Tab>^Ws
    \ <C-O><C-w>v<C-O><C-w>p<C-O>:enew<CR><C-O><C-w>p
  omenu 70.301 &Window.New\ V-&Split<Tab>^Ws
    \ <C-O><C-w>v<C-O><C-w>p<C-O>:enew<CR><C-O><C-w>p
endfunction

call s:GuiReconfigureMenu()

