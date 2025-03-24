" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Dubs Vim UX settings and mappings.

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_session_file_boss
endif

if exists('g:loaded_dubs_appearance_session_file_boss') || &cp

  finish
endif

let g:loaded_dubs_appearance_session_file_boss = 1

" -------------------------------------------------------------------

" See what OS we're on
" ------------------------------------------------------
let s:running_windows = has("win16") || has("win32") || has("win64")

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Application Startup and Shutdown
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" SAVVY/2025-03-07: I'm not going to adjust this for Neovim.
" - It still works, though it uses ~/.vim/sesssions
" - There are much better Session plugins! Go use one of those instead.
"   - This was just a naïve approach because I often had issues reloading
"     Session files, especially after tweaking Vim config.
"   - So I'd generally restart Vim without reloading a Session file:
"     - You'll see below that if you close all buffers before quiting
"       Vim, it'll destroy the Session file. And that's usually what I'd
"       do, close all buffers and start fresh on the next invocation.

if !s:running_windows
  let s:user_vim_dir = $HOME .. "/.vim"
else
  let s:user_vim_dir = $HOME .. "/vimfiles"
endif

" Save current session on exit
" ------------------------------------------------------
"
" REFER:
" - Vim's default |'sessionoptions'|
"     sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
" - Neovim's default:
"     sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
"   Note that Neovim's default remove 'options', and it adds 'terminal'.
" - DUNNO: I recall in Vim having an issue with config changes not taking
"   effect after loading a Session file. E.g., if I changed *this* file,
"   restarted Vim, and reloaded the Session, Vim would use the version of
"   this file from the old Session, because 'options' stores "all options
"   and mappings".
"   - To deal with this, I'd always delete a Session file after making config
"     changes (e.g., close all windows and buffers and quit Vim to have this
"     plugin delete the Session file).
"   - REFER: Indeed, the Neovim docs indicate, *If you leave out "options"
"     many things won't work well after restoring the session.*
"     - Except Neovim excludes "options" by default!
"   - Given that everything works fine in Neovim after loading a Session file,
"     it doesn't seem like 'options' is necessary. (Which makes sense — if you
"     start (Neo)vim like normal before loading a Session file, all your options
"     and mappings should be configured like you except. So, if anything, it
"     seems like you *shouldn't* ever want to reload 'options'!)
"   - Given that, when running Vim: delete Session.vim if you edit this file,
"     or any config. (Altly, we could remove 'options', but I've migrated to
"     Neovim and don't run Vim anymore, and I don't use this plugin anymore
"     (which begs the question, why did I bother to update this comment? =).)
"
" NOTE I still haven't figured out unloaded/
"      hidden buffers, such that :Bdelete all and
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
"
" CALSO/2024-12-10: Courtesy Tim Pope:
" - *obsession.vim: continuously updated session files*
"   https://github.com/tpope/vim-obsession

autocmd VimLeave * nested call <SID>ManageSessionFile()

function! s:ManageSessionFile() abort
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

      if (bufname(n) == '')
        let empty_buffers = empty_buffers + 1
      endif
    endif

    let n = n + 1
  endwhile

  let l:sessions_dir = s:user_vim_dir .. '/sessions'
  let l:session_file = l:sessions_dir .. '/' .. v:servername .. '.vim'

  if (num_buffers == 1) && (empty_buffers == 1)
    call delete(l:session_file)
  else
    if (!isdirectory(s:user_vim_dir))
      call mkdir(s:user_vim_dir)
    endif

    if (!isdirectory(l:sessions_dir))
      call mkdir(l:sessions_dir)
    endif

    execute 'mksession! ' .. l:session_file
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

function! s:LoadSessionFile() abort
  if (v:servername == '') || (bufname(1) != '')

    return
  endif

  let greatest_buf_no = bufnr('$')
  if (greatest_buf_no > 1)

    return
  endif

  let l:sessions_dir = s:user_vim_dir .. '/sessions'
  let l:session_file = l:sessions_dir .. '/' .. v:servername .. '.vim'

  if filereadable(l:session_file)
    execute 'source ' .. l:session_file
  endif
endfunction

