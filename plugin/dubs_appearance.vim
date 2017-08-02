" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.08.01
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Basic Vim configuration (no functions; just settings and mappings)
" License: GPLv3
" ----------------------------------------------------------------------------
" Copyright © 2009, 2015-2017 Landon Bouma.
"
" This file is part of Dubsacks.
"
" Dubsacks is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation, either version
" 3 of the License, or (at your option) any later version.
"
" Dubsacks is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty
" of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
" the GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with Dubsacks. If not, see <http://www.gnu.org/licenses/>
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
" NOTE I still haven't figured out unloaded/
"      hidden buffers, such that :Bclose all and
"      restarting Vim starts with the buffers
"      you just closed -- as a kludge, we'll
"      just not re-write the session file if
"      <Alt-f>e was just called.
autocmd VimLeave * nested
  \ let last_buffer = bufnr('$') |
  \ let num_buffers = 0 |
  \ let empty_buffers = 0 |
  \ let n = 1 |
  \ while n <= last_buffer |
  \   if (buflisted(n)) |
  \     let num_buffers = num_buffers + 1 |
  \     if (bufname(n)== "") |
  \       let empty_buffers = empty_buffers + 1 |
  \     endif |
  \   endif |
  \   let n = n + 1 |
  \ endwhile |
  \ if (num_buffers == 1)
  \     && (empty_buffers == 1) |
  \   call delete(
  \     s:user_vim_dir . "/Session.vim") |
  \ else |
  \   if (!isdirectory(s:user_vim_dir)) |
  \     call mkdir(s:user_vim_dir) |
  \   endif |
  \   execute "mksession! " .
  \     s:user_vim_dir . "/Session.vim" |
  \ endif

" Restore previous session on open
" ------------------------------------------------------
" Inspired by
"   http://vim.wikia.com/wiki/Open_the_last_edited_file

" Restore previous session on startup
" ------------------------------------------------------
" ... but not if specifically opening a file; in
" other words, just restore the previous session
" if user clicked gVim.exe, but not some dumb
" text file.
" NOTE (argc() == 0) is true even when double-
"      clicking from Explorer, so it's not a
"      reliable indicator of whether a file is
"      being opened (as the aforementioned wikia.
"      com link may lead you to believe);
"      rather,
autocmd VimEnter * nested
    \ let greatest_buf_no = bufnr('$') |
    \ if (greatest_buf_no == 1)
    \     && (bufname(1) == "")
    \     && filereadable(
    \       s:user_vim_dir . "/Session.vim") |
    \   execute "source " .
    \     s:user_vim_dir . "/Session.vim" |
    \ endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Opening and Backing up Files
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Delete default Vim buffer
" ------------------------------------------------------
" If you're not already running gVim and you
" double-click a file from Explorer, (or run
" gVim from the command line), gVim opens your
" file, but also opens a nameless buffer (and
" then hides it when your file is opened).
" You'd think this wouldn't be the default,
" or there'd be a way to stop it, but, alas...
" I guess we're responsible for cleaning up
" this mess.
let s:CleansedBufList = 0
function! s:CleanseBufList(bang)
  let last_buffer = bufnr('$')
  let delete_count = 0
  let n = 1
  echomsg "CleansedBufList: last_buffer:" last_buffer
  sleep 2000
  if last_buffer > 0
     while n <= last_buffer
       " NOTE I'm assuming when we restore Session.-
       "      vim that there's just one unnamed
       "      buffer and that it's the empty one
       "      created on startup. However, I could
       "      be wrong (I haven't verified this
       "      through reading the help), so who
       "      knows if this ever might fail (if
       "      which case your documents don't get
       "      opened -- whatever, so you just fix
       "      this script and know that I was wrong
       "      to assume).
       try
         if (buflisted(n))
            \ && (bufname(n) == "")
            \ && (getbufvar(n, "&mod") == 0)
            " You can run the command, &modifed, to check if the current buffer
            " is modified, or you can use getbufvar on any buffer.
            " 2014.02.04: See comments before autocmd SessionLoadPost
            "   call this fcn: This bdelete can cause Vim to enter an
            "   infinite loop if your Session.vim isn't cleared
            "   properly...
           execute "bdelete" . a:bang . ' ' . n
           if ! buflisted(n)
             let delete_count = delete_count + 1
           endif
         endif
       catch /.*/
         echomsg "CleansedBufList thrown.  Value is" v:exception
       endtry
       let n = n + 1
     endwhile
  endif
  " Pretty-print a message 'splaining whaddup
  if delete_count == 1
    let plural = ""
  else
    let plural = "s"
  endif
  echomsg "CleansedBufList: " . delete_count
    \ . " buffer" . plural . " deleted"
  " Remember that we've cleansed
  let s:CleansedBufList = 1
endfunction

" Run CleanseBufList just once, right
" after we start and load Session.vim
" 2014.02.04: This doesn't work well.
"   To see it: cd to an svn directory.
"   Run: svn diff | gvim -
"   Type Alt-F+E then Alt-F+X to exit.
"   The Alt-F+E doesn't do it's all because
"   the diff buffer is modified/unsaved.
"   So when you exit without saving and start
"   Vim again, either the file doesn't show,
"   or, worse yet, Vim gets stuck in a loop
"   somewhere...
"autocmd SessionLoadPost * nested
"  \ if 0 == s:CleansedBufList |
"  \   :call <SID>CleanseBufList('') |
"  \ endif |
"  \ let s:CleansedBufList = 1
" And how come I never seen a tip fer this
" on-line, eh, vim.org? eh, vim.wikia.com?
" 'cause usually when I can't Google something...
" it means I'm wrong! ...but I digress...
" (seriously, I'm probably just missing a
"  setting somewhere...)

" Common Backup file and Swap Directory
" ------------------------------------------------------
" Use a common directory for backups and
" swp files; creates the backup dir if new
let s:backupDir = '"' . $HOME . '/.vim_backups' . '"'
silent execute "let s:backupFtype = getftype(" . s:backupDir . ")"
if "" == s:backupFtype
  silent execute '!mkdir ' . s:backupDir
elseif "dir" != s:backupFtype
  call confirm('Backup directory exists but is not a directory! '
    \ . 'Dir: ' . s:backupDir . ' / Type: ' . s:backupFtype)
endif
set backupdir=$HOME/.vim_backups/
set directory=$HOME/.vim_backups/

" Skip Backups
" ------------------------------------------------------
" Backups are only written when you save a
" file, anyway, so I don't see the point
" (I save all the time: I'm from the old-school
"  '80s and '90s camp, sans journaling file systems,
"  where if ya crashed, ya crashed, and all yer data
"  went away!).
" Additionally, Vim maintains ~/.vim_backups, so
" if Vim crashes, you're fine.
" Basically: use revision control for "backups".
set nobackup

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Miscellany
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable syntax highlighting
" ------------------------------------------------------
" This is enabled by default in Windows
" but not in Linux.
syntax enable

" Command-line Copy
" --------------------------------
" gVim/win maps Ctrl-C to yank, but only
" in Normal and Insert modes. Here we make
" it so Ctrl-C also works in the
" Command-line window.
cmap <C-C> <C-Y>

" Start Big
" ------------------------------------------------------
" Start with a reasonably sized window for GUIs
" (ignore for CLI so we don't change terminal size)
if has("gui_running")
  " winpos 100 100
  " set columns=111 lines=44
  " 2010.06.24 Work config:
  " FIXME Home config; if 'fa', winpos 0 0 ?
  winpos 718 0
  set columns=121 lines=68
endif
" NOTE To start maximized:
"      au GUIEnter * simalt ~x

" XXX It's Courier New 9, Folks! XXX
" 2017-06-27: It's Hack Regular 9, Folks, since Aug 17, 2015, Go Dubsacks!
" ------------------------------------------------------------------------
if has("gui_running")
  " How come Courier New isn't the default?
  if s:running_windows
    set guifont=Courier_New:h9
  else
    " set guifont=Courier\ New\ 9
    " NOTE In Debian, just setting guifont makes
    "      things look like shit; not sure why this
    "      doesn't happen in Fedora. Anyway, comment
    "      this out or unset guifont to fix font issues.
    "      ... or don't run Debian!
    if filereadable($HOME . "/.fonts/Hack-v2_010-ttf/Hack-Regular.ttf")
      set guifont=Hack\ Regular\ 9
    else
      set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
    endif
  endif
  " Get rid of silly, space-wasting toolbar
  " Default is 'egmrLtT'
  set guioptions=egmrLt
  " Hide the mouse pointer while typing
  " NOTE This does not hide the mouse in
  "      Windows gVim, so it's off! for now
  "set mousehide
endif

" Show line numbers
" ------------------------------------------------------
set nu!

" Pretty Print
" ------------------------------------------------------
" Change the color of the line numbers
" from deep red (default) to dark grey
" (it's less abusive to the eye this way).
:highlight LineNr term=NONE cterm=NONE
  \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
  \ guifg=DarkGrey guibg=NONE
" 2012.09.21: Add colors for :list. See :h listchars. You can show whitespace.
" Hmmm, the trail:~ puts tildes after the last line number... kinda weird lookn
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
:highlight SpecialKey term=NONE cterm=NONE
  \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
  \ guifg=DarkGrey guibg=NONE
" FIXME: 2012.09.21: This isn't working from here: you can manually
" :set list and then :highlight... and the whitespace chars are shown
" in the same gray as the line numbers, but if you just :set list, the
" whitespace chars don't appear, even with the same highlight here....
:highlight NonText term=NONE cterm=NONE
  \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
  \ guifg=DarkGrey guibg=NONE
":highlight NonText term=NONE cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" Default to not showing whatspace.
set nolist

" What Are You Hiding From Me?
" ------------------------------------------------------
" Show new buffers w/ all folds open
" (See http://vim.wikia.com/wiki/Folding)
" TODO can i use autocmd BufAdd * ?? <C-a><C-o>zO
"      'cause foldlevelstart=20 isn't bullet-
"       proof ??
set foldlevelstart=20

" Search Behavior
" ------------------------------------------------------
" Case-insensitive searches
" 2012.07.15: My old comment says,
"               NOTE /You can override this with/I
"             But it's really \c or \C that you want,
"               /\CCase Sensitive Incremental Search
"             You can put the '\C' wherever you want.
"             (The \c does lowercase, \CDUH.)
"             See :h ignorecase
set ignorecase
" Better yet, search case sensitive if the
" search term contains a capital letter
set smartcase
" These should be set by default:
"   set hlsearch  " Highlight search terms
"   set incsearch " search dynamically as keyword is typed
" but on my Ubuntu box, unlike Windows, they're not, so
set hlsearch  " Highlight search terms
set incsearch " search dynamically as keyword is typed

" Drop a Deuce on that Tab
" ------------------------------------------------------
" Anyone out there still tabbing?
" How 'bout you spacers using 4?
" Seems the Rubyists have got me
" down to 2... what's next, reverse
" indenting?
" No, wait!: Elastic tabs! Hahaha.
"
" 2014.01.07: See CycleThruStyleGuides. Let the smart
"             fcn. do the work, lest we screw up, e.g.,
"             filetype=help formatting.
"set expandtab
"set tabstop=2
"set shiftwidth=2
" Honor in-file modelines, at least for *.txt ft=help files.
set modeline
"
set autoindent
" smartindent is too smart and doesn't
" indent lines that look like C macros,
" i.e., those that start with an octothorpe;
" if you hit return, get an indent, type '#',
" smartindent moves the pound to the start of
" the line (this might just be with .py files,
" not sure...)
" set smartindent
" FIXME 2011.01.17 I think this problem no longer happens...
"       so setting smartindent instead
"set nosmartindent
set smartindent
"set smarttab

" Something Something Something
" ------------------------------------------------------
" NOTE I thought autowrite was suppose to
"      cause the buffer to be written to disk
"      whenever you changed buffers, but it
"      doesn't really seem to do anything...
"set autowrite

" Enable Vim Command-line Completion
" ------------------------------------------------------
" Can't remember a command's proper name?
" Hit <Tab> (!)
set wildmenu

" Always show a status line (show line and column numbers; see also: ruler)
" ------------------------------------------------------
au VimEnter * set laststatus=2

" All Quiet on the Vimmer Front
" ------------------------------------------------------
" I tried noerrorbells and novisualbell to
" no avail, but this seems to do the trick.
set vb t_vb=

" Windows Grep Complaint Silencer
" ------------------------------------------------------
" Windows gVim complains when you grep using a path
" with backslashes in it... not sure why it complains
" since it doesn't actually do anything about it.
if has("gui_win32")
  silent !set nodosfilewarning=1
endif

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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Color Scheme
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" I like the White background that the default
" color scheme uses, but the color scheme still
" needs a little tweaking.

" Tone down the tildes
" ------------------------------------------------------
" Vim displays tildes (~) to represent lines that
" appear in a window but are not actually part of
" the buffer (i.e., for visual lines that follow
" the last line of a buffer). This isn't too
" distracting unless you verially split a window,
" then the empty buffer on the right is full of
" colorful blue tildes. You could tone this done
" by, say, changing the tildes to pink, i.e.,
"
"   highlight NonText guifg=Pink2
"
" but, really, since Vim is displaying line
" numbers -- and since line numbers are only
" displayed for actual lines in the document --
" we don't even need the tildes! You can simply
" infur the end of the document by where the line
" numbers are no longer displayed. (Note that
" guifg=NONE seems like the proper way to do
" this, but it makes the tildes black, not
" transparent (or maybe I missed something when I
" tried it).)
highlight NonText guifg=White

" Mock zellner
" ------------------------------------------------------
" The zellner color scheme changes the status
" line for the active window. The default is that
" each status line (i.e., the line beneath each
" window) is white text on a black background,
" save for the active window (the window where
" the cursor is), which is yellow text on a dark
" gray background. (For the default color scheme,
" the active window's status line is bold white
" on black, and inactive windows' status lines
" are normal white on black.)
"
" This is what's set in zellner.vim:
"
"    highlight StatusLine
"    \ term=bold,reverse cterm=NONE |
"    \ ctermfg=Yellow ctermbg=DarkGray |
"    \ gui=NONE guifg=Yellow guibg=DarkGray
"
" Note that zellner does not specify StatusLineNC
" (for inactive windows), so it remains the
" default -- white foreground and black
" background. This is annoying; I don't like some
" status lines being black and one being dark
" gray, so let's make them all dark gray. This
" means using the same settings zellner uses for
" StatusLine, but also adding StatusLineNC,
" specifying that inactive windows' status lines
" use the same background as the active window
" status line but instead use a white foreground
" (font) color.
highlight StatusLineNC term=reverse gui=NONE
  \ guifg=White guibg=DarkGray
  \ ctermfg=White ctermbg=DarkGray
highlight StatusLine term=bold,reverse gui=NONE
  \ guifg=Yellow guibg=DarkGray
  \ cterm=NONE ctermfg=Yellow ctermbg=DarkGray

" Visually Appealing Vertical Split
" ------------------------------------------------------
" When you split a window vertically, there's a
" column of black rectangles that runs between
" the two windows, and each black rectangle has
" a vertical bar in it. This, to me, is very
" distracting!
"
" And you really don't need these rectangles- the
" line numbers in each window provide adequate
" visual separation.
"
" So I like to hide the rectangles.
"
" This is also helpful if you like working with
" narrow text columns but enjoy having whitespace
" on the right side of the editor.
"
" Bare with me while I describe this: I like
" working with two vertical windows, each 50
" characters wide, with my working buffer in the
" left window and an empty buffer in the right.
" Since the buffer in the right window is empty,
" only line number 1 is displayed, and so you end
" up with an awesome chunk of whitespace. Why not
" just work in one window that's 50 characters
" wide? Well, 'cause then your buffer is squished
" in a narrow gVim window and your desktop picture
" is distractingly close to what you're working on.
" Weird, right? Something about how my brain is
" wired...
"
" So here's what we'll do: we'll set linebreak,
" which complements wrap by wrapping lines only
" where visually pleasing, i.e., at the nearest
" whitespace character or punctuation.
" Specifically, :set breakat? returns
"
"    breakat= ^I!@*-+;:,./?
"
" We'll also modify the black rectangles with the
" white vertical tab characters to be white on
" white, which effectively hides them.
set linebreak
highlight VertSplit term=reverse gui=NONE
  \ guifg=White guibg=White
  \ ctermfg=White ctermbg=White

" NOTE When working with two vertically split
"      windows, the left one container your
"      document and the right one containing an
"      empty buffer, the scroll bar for your
"      document is on the left side of the gVim
"      window, rather than on the right. You'll
"      probably eventually get used to this....

" ------------------------------------------------------
" Auto-indent selected code
" ------------------------------------------------------

" SEE INSTEAD: Select code, <Ctrl-O>= fixes code indenting (auto-indents).
" [lb] doesn't use this fcnality, ever.

" ------------------------------------------------------
" Auto-indent selected code
" ------------------------------------------------------

" Switch on cindent automatically for all files.
" 2017-06-27: See possibly comments in filetype.vim.
filetype indent on

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

" ------------------------------------------------------
" Change Search highlight
" ------------------------------------------------------

" Seriously, do I just want to be different?
":hi Search guibg=Green
:hi Search guibg=LightGreen

" ------------------------------------------------------
" Fiddle with smart indent settings
" ------------------------------------------------------

" FIXME/2017-06-27: This is a very moldy comment. Meh:
"   FIXME: Applies just to Python, maybe others
"   EXPLAIN: You removed colons: because...?
"   because in Python it causes an auto-indent?
"   But I still have problems when I type : in python:
"     it still reformats my line. So I assume these sets
"     are in vain.
"   :set cinkeys=0{,0},0),:,!^F,o,O,e
:set cinkeys=0{,0},0),!^F,o,O,e
" :set indentkeys=0{,0},:,!^F,o,O,e,<:>,=elif,=except
:set indentkeys=0{,0},!^F,o,O,e,<:>,=elif,=except

" Read about "Contextual Indent", i.e., why to do write code like,
"
"   my function(arg1,
"               arg2,
"               ...)
"
"  http://milan.adamovsky.com/2010/08/contextual-indent.html

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

" The menu is created and populated
"   $VIMRUNTIME/menu.vim
if has("menu") && has("gui_running")

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

endif " has("menu") && has("gui_running")

