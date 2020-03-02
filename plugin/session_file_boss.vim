" Dubs Vim UX settings and mappings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_session_file_boss") || &cp
  finish
endif
let g:loaded_session_file_boss = 1

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

