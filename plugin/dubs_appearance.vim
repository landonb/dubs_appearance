" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2020.03.01
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Basic Vim configuration (no functions; just settings and mappings)
" License: GPLv3
" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" ----------------------------------------------------------------------------
" Copyright © 2009, 2015-2018, 2020 Landon Bouma.
"
" This file is part of Dubs Vim.
"
" Dubs Vim is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation, either version
" 3 of the License, or (at your option) any later version.
"
" Dubs Vim is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty
" of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
" the GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with Dubs Vim. If not, see <http://www.gnu.org/licenses/>
" or write Free Software Foundation, Inc., 51 Franklin Street,
"                     Fifth Floor, Boston, MA 02110-1301, USA.
" ===================================================================

if exists("g:plugin_dubs_appearance") || &cp
  finish
endif
let g:plugin_dubs_appearance = 1

" See what OS we're on
" ------------------------------------------------------
let s:running_windows = has("win16") || has("win32") || has("win64")

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Application Startup and Shutdown
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if !s:running_windows
  let s:user_vim_dir = $HOME . "/.vim"
else
  let s:user_vim_dir = $HOME . "/vimfiles"
endif

" Save current session on exit
" ------------------------------------------------------
"
" NOTE Vim's default is to set
"        sessionoptions=blank,buffers,curdir,
"          \ folds,help,options,tabpages,winsize
"      which means we can't update _this_ file
"      without first deleting ~/.vim/Session.vim
"      or ~/vimfiles/Session.vim -- otherwise,
"      Session.vim overrides any changes we make
"      here (because it stores mappings, etc.,
"      and is loaded after this file).
"      Alternatively, we could set
"      sessionoptions to save only winsize,
"      buffers, etc., but not options: though I
"      haven't tested this, so for now: delete
"      Session.vim if you m*ck w//touch this
"      fi#e.
"
" NOTE I still haven't figured out unloaded/
"      hidden buffers, such that :Bclose all and
"      restarting Vim starts with the buffers
"      you just closed -- as a kludge, we'll
"      just not re-write the session file if
"      <Alt-f>e was just called.
"
" NOTE/2018-06-11: Only save session file (a/k/a
"      Session.vim) if --servername was used, so
"      that we don't start sessioning one-off
"      uses, e.g., via `git commit`; and so that
"      having more than one instance of vim open
"      doesn't cause session file confusion.
"
" MAYBE/2018-06-11: (lb): Not sure we needed 'nested',
"      but it's always forever been here, so leaving.

autocmd VimLeave * nested call <SID>ManageSessionFile()

function! s:ManageSessionFile()
  if (v:servername == '')
    return
  endif

  let last_buffer = bufnr('$')
  let num_buffers = 0
  let empty_buffers = 0
  let n = 1
  while n <= last_buffer
    if (buflisted(n))
      let num_buffers = num_buffers + 1
      if (bufname(n) == "")
        let empty_buffers = empty_buffers + 1
      endif
    endif
    let n = n + 1
  endwhile

  let l:sessions_dir = s:user_vim_dir . "/sessions"
  let l:session_file = l:sessions_dir . "/" . v:servername . ".vim"

  if (num_buffers == 1)
      && (empty_buffers == 1)
    call delete(l:session_file)
  else
    if (!isdirectory(s:user_vim_dir))
      call mkdir(s:user_vim_dir)
    endif
    if (!isdirectory(l:sessions_dir))
      call mkdir(l:sessions_dir)
    endif
    execute "mksession! " l:session_file
  endif
endfunction

" Restore previous session on startup
" ------------------------------------------------------
" ... but not if opening a file on invocation.
"
" Inspired by
"   http://vim.wikia.com/wiki/Open_the_last_edited_file
"
" NOTE: Windows: (argc() == 0) is true even when double-
"       clicking from Explorer, so it's not a reliable
"       indicator of whether a file is being opened (as
"       the aforementioned wikia.com link may lead you
"       to believe); rather,
"
" NOTE/2018-06-11: When run for git-commit, (e.g., because
"       core.editor), the buffer name is COMMIT_EDITMSG
"       Which is not a file (or maybe it's a temp file?).
"       In any case, don't do Sessioning for git. To detect,
"       we'll use the --servername, which won't be set for
"       git. (This is also a more robust solution in general,
"       and will work for other apps that work similarly.)
"
" MAYBE/2018-06-11: (lb): Not sure we needed 'nested',
"      but it's always forever been here, so leaving.

autocmd VimEnter * nested call <SID>LoadSessionFile()

function! s:LoadSessionFile()
  if (v:servername == '') || (bufname(1) != "")
    return
  endif

  let greatest_buf_no = bufnr('$')
  if (greatest_buf_no > 1)
    return
  endif

  let l:sessions_dir = s:user_vim_dir . "/sessions"
  let l:session_file = l:sessions_dir . "/" . v:servername . ".vim"

  if filereadable(l:session_file)
    execute "source " . l:session_file
  endif
endfunction

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Opening and Backing up Files
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Miscellany
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable syntax highlighting
" ------------------------------------------------------
" This is enabled by default in Windows
" but not in Linux.
syntax enable

" Show line numbers
" ------------------------------------------------------
set nu!

" Do not replace final whitespace character of tab with \
" ------------------------------------------------------
" 2017-12-09: Defaults to off, anyway; not sure why this is explicit.
set nolist

" What Are You Hiding From Me?
" ------------------------------------------------------
" Show new buffers w/ all folds open
" (See http://vim.wikia.com/wiki/Folding)
" TODO can i use autocmd BufAdd * ?? <C-a><C-o>zO
"      'cause foldlevelstart=20 isn't bullet-
"       proof ??
set foldlevelstart=20

" Something Something Something
" ------------------------------------------------------
" NOTE I thought autowrite was suppose to
"      cause the buffer to be written to disk
"      whenever you changed buffers, but it
"      doesn't really seem to do anything...
"set autowrite

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

" ------------------------------------------------------
" Highlight Characters Past Our Desired Line Width
" ------------------------------------------------------
" http://vim.wikia.com/wiki/Highlight_long_lines

" See Cyclopath.vim: the user can cycle through a list of
"                    style convention policies
"
" In any case, the command is something like the following.
" The :match command changes the color of characters that
" match the specified pattern
"   :match ErrorMsg '\%>80v.\+'
" You can turn off this feature using
"   :match none
" Lastly, I'm not sure what this command does, though I think
" I was using it to test. It might split longs lines, I dunno...
"   :g/\%>79v/norm 77|gElC...

" gVim Right-Click Menu
" ---------------------

" 2018-12-09: Learn something new everyday:
" Dubs Vim will (should) by default give a right-click popup context menu,
" via `set mousemodel=popup`. However, if you start without plugins, e.g.,
" `gvim --noplugin`, right-clicking extends a selection (=extend) instead.
" For more, :help popup-menu.

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

call <SID>DubsAppearance_Main()

" ------------------------------------------------------

