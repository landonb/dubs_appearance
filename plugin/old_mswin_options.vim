" Deprecated: Old Dubs Vim Windows hack to remove new buffer created on file open.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_old_mswin_options") || &cp
  finish
endif
let g:loaded_old_mswin_options = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Grepping Files
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Windows Grep Complaint Silencer
" ------------------------------------------------------
" Windows gVim complains when you grep using a path
" with backslashes in it... not sure why it complains
" since it doesn't actually do anything about it.
if has("gui_win32")
  silent !set nodosfilewarning=1
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Opening Files
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

