" Dubs Vim Backup Behavior.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_backupno_disabled") || &cp
  finish
endif
let g:loaded_backupno_disabled = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Opening and Backing up Files
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
"  went away! -So I save always, save often.).
" Additionally, Vim maintains ~/.vim_backups, so
" if Vim crashes, you're fine.
" Also: Use revision control for "backups".
set nobackup


