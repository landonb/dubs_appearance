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

" Hack Regular 9. Proudly using since Aug 17, 2015.
" ------------------------------------------------------------------------
function! s:GTKSetFontHack()
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
    " FIXME/2017-11-04: Make this dynamic, hardcoder!
    " 2017-12-05: I tried Knack, which is Hack plus extras,
    " but the Powerline glyphs have a one-character padding
    " on the left. Weird. Makes statusline look funky. Oh, well...
    "    if filereadable($HOME . "/.local/share/fonts/NerdFonts/Knack\ Regular\ Nerd\ Font\ Complete.ttf")
    "      set guifont=Knack\ Nerd\ Font\ 9
    if len(glob($HOME . "/.fonts/Hack-v*-ttf/ttf/Hack-Regular.ttf")) > 0
      set guifont=Hack\ Regular\ 9
    else
      "set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
      " 2017-12-09: Courier is probably a more reliable default.
      set guifont=Courier\ New\ 9
    endif
  endif
endfunction

function! s:GuiSetFont()
  " MAYBE/2018-12-24: Make the font more easily themeable.
  "   For now, being opinionated: You should install Hack!
  "   Otherwise, I'll settle for Courier New 9, 'snot bad.
  "   - See also Fira Code, if you like, e.g., "≥" done easy.
  if has("gui_running")
    " From http://vim.wikia.com/wiki/VimTip632
    if has("gui_gtk2") || has("gui_gtk3")
      call s:GTKSetFontHack()
    elseif has("gui_photon")
      set guifont=Courier\ New:s9
    elseif has("gui_kde")
      set guifont=Courier\ New/9/-1/5/50/0/0/0/1/0
    elseif has("x11")
      set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
      set guifont=Courier_New:h9:cDEFAULT
    endif
endfunction

call s:GuiSetFont()

" ------------------------------------------------------

" *** Configure the &guioptions setting.
"
" The default guioptions depend on the platform:
"
"   'aegimrLtT' (GTK)
"   'egmrLtT'   (Windows)
"
" These are the default flag options (* indicates GTK-only):
"
"   * 'a' “Autoselect”: something about what's selected being automatically
"         added to the clipboard, or maybe I read the help wrong, because
"         I tested with and without this setting, and I could not figure
"         out how it works. So we'll exclude this option, I don't think
"         we're missing anything.
"           To test again: set guioptions+=a
"     'e' “Add tab pages when indicated with 'showtabline'.” Dubs Vim does
"         not reference 'showtabline', except now in this comment, and it's
"         always had this option enabled, so leaving enabled, though I'm
"         not sure how it operates/what it does.
"           To test without: set guioptions-=e
"     'g' “Grey menu items: Make menu items that are not active grey.” We can
"         leave this enabled, in case the user wants shows the menu bar again.
"   * 'i' “Use a Vim icon.” I.e., what you see when you Alt-Tab, and what you
"         see in the MATE (or Gnome, whatever) Window List Panel (e.g., the
"         MATE Window List application is /usr/lib/mate-panel/wnck-applet).
"         - 2020-03-01: This has never been enabled in Dubs Vim (not since 2009),
"           but I did not leave myself a note why, which leaves me w/ 2 guesses:
"           (a) I forgot about this setting when I migrated from developing on
"           Windows to Linux sometime last mid-decade (though you'd think my
"           10-year-younger self would have noticed and cared that guioptions
"           is different depending on the platform, and would have written an
"           if-else block to set guioptions accordingly; but also maybe I was
"           more naive back then); or, perhaps
"           (b) I deliberately disabled this option (but did not comment why)
"           because I find the Vim icon ugly and dated. But if that's the case:
"           MAYBE/2020-03-01: Customize the Vim icon (to your liking). (Now that
"           I figured out how to get gvim to set an icon for the window manager,
"           can I easily edit and customize that icon? To personalize it to my
"           taste?)
"     'm' “Menu bar is present.” As mentioned in later comment section, hiding.
"     'r' “Right-hand scrollbar is always present.”. A feature that you'd at
"         first think you want -- because all graphical text editors would use
"         one, right? -- and that Dubs Vim has had enabled since its humble
"         roots in 2009. But now it's 2020, and scrollbars are so dated. Who
"         uses them anymore? Maybe as a visual reference to gauge how big a
"         file is, or maybe to see where the cursor is relative to the top
"         or bottom of a file; but both of those informations can be gleaned
"         (and more precisely, too), from the status footer (aka mescaline)
"         (well, so long as the file path is not so long that it clips those
"         details from the status line). As for scrolling, I either use keys
"         (Ctrl-Up/-Down, Page Up/Down, gg, G, Ctrl-Home, etc.) or the mouse
"         wheel; I cannot recall the last time I grabbed a scrollbar elevator.
"     'L' “Left-hand scrollbar is present when ... a vertically split window.”
"         For same reasons as right-hand scrollbar, hiding, because I only used
"         the scrollbar as a visual cue to tell the relative line position and
"         file length, but that information is included (and more precisely, too)
"         in the dubs_mescaline status line below each window.
"     't' “Include tearoff menu items.” A 'cute' feature that lets you float
"         menus and submenus, but also which seems completely useless. I cannot
"         think of a good use case. Maybe if I wanted to repeat the same command
"         over and over again using my mouse, or something? In any case, leaving
"         enabled, because it doesn't get in the way, and it's always been part
"         of the team.
"     'T' “Include Toolbar.” That row of useless clickable icons wired to a few
"         simple commands. Dubs Vim has hidden the toolbar since Dubs Vim's
"         inception back in 2009, and Dubs Vim plans to continue to shun the
"         Vim Toolbar in perpetuity.
"
" Dubs Vim historically (for the past 10 years, since 2009) has hidden the
" toolbar, but it has not hidden the menu bar, noting: "Get rid of (hide) the
" silly, space-wasting Vim toolbar (but not menu bar)."
" - 2020-03-01: But I've grown since then. And now I want to hide the menu bar:
"   - I'd rather have the additional line space (1 more row in my editor!).
"   - I'd appreciate less clutter in my view, especially when Vim is fullscreen.
"   - I never use the menu for discovery (to see what commands are available),
"     and I never interact with the menu using the mouse; but I do use the
"     alt-key menu combinations, which is not because I'm lazy and did not
"     bother learning the equivalent Vim builtins, but it was because the
"     alt-key menu hooks work in insert mode, and the Vim builtins do not.
"     (E.g., Vim's <Ctrl-w>q command closes a window from normal mode, but
"     <Ctrl-w> has a different meaning in insert mode. So I would always use
"     the menu bar's <Alt-w>c, which works from both modes!)
"   - To keep the same user experience, just without the menu bar,
"     we'll recreate the menu bar key mappings that we want to keep.
"     - We can use Vim's normal `map` mechanism to recreate the mappings,
"       essentially duplicating the `amenu` commands we want to recreate
"       (but using a normal-looking key binding like <M-w>c, rather than
"       the cute title-and-shortcut-in-one syntax like `&Window.&Close`).
"
" If you run Vim with any or all of these options enabled, you can easily
" disable any one of them:
"   :set guioptions-=m  " remove menu bar
"   :set guioptions-=T  " remove toolbar
"   :set guioptions-=r  " remove right-hand scroll bar
"   :set guioptions-=L  " remove left-hand scroll bar
" Or if you run Dubs Vim with any of these options disabled, you can easily
" enable any one/each of them:
"   :set guioptions+=m  " show menu bar
"   :set guioptions+=T  " show toolbar
"   :set guioptions+=r  " show right-hand scroll bar
"   :set guioptions+=L  " show left-hand scroll bar (when vertical split present)
"
" - HINT/2020-03-01: To be extra clear, the menu bar is still configured as
"   it's always been (that code still exists below), but now we're hiding it
"   on startup. If you want to see the menu bar at any time, simply run:
"
"         set guioptions+=m  " See what you're missing.
"
function! s:GuiSetGuioptions()
  if !has("gui_running") | return | endif
  " See long comments above.
  " - These options differ from the default/builtins by hiding
  "   these elements: menubar; toolbar; always right scrollbar;
  "   sometimes left scrollbar.
  " - 2020-03-01: These options also exclude 'a' (Autoselect)
  "   which I read about today but could not see have any effect
  "   on my machine, and since I did not ever have 'a' as an option
  "   in Dubs Vim, I'm not adding it now (just adding this comment).
  set guioptions=egit
endfunction

call s:GuiSetGuioptions()

function! s:MimicUsefulGuiMenuShortcutKeyMappings()
  " FIXME/2020-03-01: Will flesh out after first committing GuiSetGuioptions changes.
endfunction

call s:MimicUsefulGuiMenuShortcutKeyMappings()

" ------------------------------------------------------

function! s:ThemeResetMouse()
  if !has("gui_running") | return | endif
  " Hide the mouse pointer while typing
  " NOTE This does not hide the mouse in
  "      Windows gVim, so it's off! for now
  "set mousehide
endfunction

" call s:ThemeResetMouse()

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
" See CycleThruStyleGuides for intelligent tab settings,
" or use a modeline. Or let Vim figure it out, i.e., do
" not mess up style for :help docs. And no to elastic tabs.
"set expandtab
"set tabstop=2
"set shiftwidth=2
"
" Honor file header and footer modelines, e.g.,
"   vim:tw=78:ts=8:ft=help:norl:
"   vim:tw=0:ts=2:sw=2:et:norl:ft=vim
"   etc.
" MAYBE/2017-11-04: Can this be disabled because CycleThruStyleGuides_FixMatch?
"   Things work well as is, so no point to answer.
set modeline

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
" 2017-12-09: See also dubs_mescaline
"   github.com/landonb/dubs_mescaline
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

" Break lines on word boundaries
" ------------------------------------------------------
" Set linebreak, which complements wrap by wrapping lines
" only where visually pleasing, i.e., at the nearest
" whitespace character or punctuation.
" Specifically, :set breakat? returns
"
"    breakat= ^I!@*-+;:,./?
set linebreak

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
" - :help filetype-indent-on
"   "Enable loading the indent file for specific file types."
" FIXME/2017-12-10: Do you actually use any indent files?
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
" Fiddle with smart indent settings
" ------------------------------------------------------

" FIXME/2017-12-10: This belongs in a filetype-specific indent/ file.
" FIXME/2017-06-27: This is a very moldy comment. Meh:
"   FIXME: Applies just to Python, maybe others
"   EXPLAIN: You removed colons: because...?
"   because in Python it causes an auto-indent?
"   But I still have problems when I type : in python:
"     it still reformats my line. So I assume these sets
"     are in vain.
"   :set cinkeys=0{,0},0),:,!^F,o,O,e
set cinkeys=0{,0},0),!^F,o,O,e
" :set indentkeys=0{,0},:,!^F,o,O,e,<:>,=elif,=except
set indentkeys=0{,0},!^F,o,O,e,<:>,=elif,=except

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

