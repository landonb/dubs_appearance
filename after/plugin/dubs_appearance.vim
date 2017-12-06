" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.12.05
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Basic Vim configuration (no functions; just settings and mappings)
" License: GPLv3
" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
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

if exists("g:after_plugin_dubs_appearance_neodark") || &cp
  finish
endif
let g:after_plugin_dubs_appearance_neodark = 1

" https://github.com/KeitaNakamura/neodark.vim
function s:SetColorScheme_NeoDark()

  "let g:neodark#background = '#202020'
  let g:neodark#background = '#060606'

  " To use 256-color in both of vim and gvim:
  "let g:neodark#use_256color = 1 " default: 0

  " To use your default terminal background:
  "let g:neodark#terminal_transparent = 1 " default: 0

  " If you want solid vertical split matching the statusline:
  let g:neodark#solid_vertsplit = 1 " default: 0

  " Airline and lightline themes are also included. For lightline,
  let g:lightline = {}
  let g:lightline.colorscheme = 'neodark'
  " For airline, just use!
  " https://github.com/vim-airline/vim-airline
  " https://github.com/itchyny/lightline.vim

  " Set the colorscheme last, after setting globals.
  colorscheme neodark
endfunction
"call <SID>SetColorScheme_NeoDark()

function s:SetColorScheme_DeepSpace()
  set background=dark
  set termguicolors
  let g:deepspace_italics=1
"  let g:airline_theme='deep_space'
  let g:lightline = {
    \ 'colorscheme': 'PaperColor light',
    \ }
    "\ 'colorscheme': 'deepspace',
  "colorscheme deep-space
  "highlight Normal gui=NONE guifg=White guibg=#060606 ctermfg=White ctermbg=none
  highlight Normal gui=NONE
    \ guifg=White guibg=#060606
    \ ctermfg=White ctermbg=none
endfunction
call <SID>SetColorScheme_DeepSpace()



" NOTE: You canNOT use, e.g., "^V" or "\^V", to match control characters.
let s:vim_mode_lookup = {
  \ "n":      "NORMAL",
  \ "no":     "N·OPER",
  \ "v":      "VISUAL",
  \ "V":      "V·LINE",
  \ "\<C-V>": "V·BLCK",
  \ "s":      "SELECT",
  \ "S":      "S·LINE",
  \ "\<C-S>": "S·BLCK",
  \ "i":      "INSERT",
  \ "ic":     "I·COMP",
  \ "ix":     "I·C-X ",
  \ "R":      "RPLACE",
  \ "Rc":     "R·COMP",
  \ "Rv":     "V·RPLC",
  \ "Rx":     "R·C-X ",
  \ "c":      "COMMND",
  \ "cv":     "VIM·EX",
  \ "ce":     "NRM·EX",
  \ "r":      "PROMPT",
  \ "rm":     "-MORE-",
  \ "r?":     "CNFIRM",
  \ "!":      "!SHELL",
  \ "t":      "TRMNAL",
  \ "":       "UNKNWN"
\ }

function s:ModeFriendlyString(mode)
  " See :help mode()
  "echom 'ModeFriendlyString: mode: ' . a:mode
  return get(s:vim_mode_lookup, a:mode, "NOTFND")
endfunction



" https://www.reddit.com/r/vim/comments/1egwbr/powerline_have_you_made_a_custom_themecolorscheme/

" https://www.reddit.com/r/vim/comments/1dyun6/why_does_powerline_make_vim_significantly_slower/c9w1kn2/

" Powerline requires a C build or Python to run... I looked at installation, but it wasn't obvious, so screw it.
"   https://github.com/powerline/powerline
"   https://powerline.readthedocs.io/en/latest/
" Just too complicated...

" Statusline modifications, added Fugitive Status Line & Syntastic Error Message {{{2
function! TickleStatusLineMode(timer_id)
  "echom 'TickleStatusLineMode: timer_id: ' . a:timer_id
  " NOTE: We don't actually need to call anything. The statusline
  " updates itself simply because this function ran (or because the
  " timer fired; not sure which does the trick).
  " So no need to call:
  "  call SetStatusLineMode()
endfunction

let g:last_mode = ''
function! SetStatusLineMode()
  let l:mode = mode()

  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    hi User2 guifg=#005f00 guibg=#dfff00 gui=BOLD ctermfg=22 ctermbg=190 cterm=BOLD
    hi User3 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=241
    hi User4 guifg=#414234 guibg=#2B2B2B ctermfg=241 ctermbg=234
    hi User5 guifg=#4e4e4e guibg=#FFFFFF gui=bold ctermfg=239 ctermbg=255 cterm=bold
    hi User6 guifg=#FFFFFF guibg=#8a8a8a ctermfg=255 ctermbg=245
    hi User7 guifg=#ffff00 guibg=#8a8a8a gui=bold ctermfg=226 ctermbg=245 cterm=bold
    hi User8 guifg=#8a8a8a guibg=#414243 ctermfg=245 ctermbg=241

" FIXME/2017-12-05: Better colors...
    "hi User9 guifg=#0000FF guibg=#FF0000 ctermfg=4 ctermbg=3
    hi User9 guibg=#005f00 guifg=#dfff00 gui=BOLD ctermbg=22 ctermfg=190 cterm=BOLD

    "echom 'l:mode: ' . l:mode
    " NOTE: ==# forces case sensitive match, in case ignorecase is enabled.
    if l:mode ==# 'n'
      hi User3 guifg=#dfff00 ctermfg=190
    elseif l:mode ==# "i"
      hi User2 guifg=#005fff guibg=#FFFFFF ctermfg=27 ctermbg=255
      hi User3 guifg=#FFFFFF ctermfg=255
    elseif l:mode ==# "R"
      hi User2 guifg=#FFFFFF guibg=#df0000 ctermfg=255 ctermbg=160
      hi User3 guifg=#df0000 ctermfg=160
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guifg=#4e4e4e guibg=#ffaf00 ctermfg=239 ctermbg=214
      hi User3 guifg=#ffaf00 ctermfg=214
    endif
  endif 

  let l:cmode = mode()
  let l:mode0 = s:omode
  let s:omode = l:cmode
  "echom 's:omode: ' . s:omode . ' / ' . 'l:cmode: ' . l:cmode
  if l:mode0 ==# 'i' && l:cmode == 'n'
    " In Insert mode, if you arrow up or arrow down, the mode toggles
    " to Normal mode and then back to Insert. (Possible because... I
    " dunno.)
    " Set a timer to correct this issue if user really did switch modes.
    "   https://github.com/vim/vim/blob/master/runtime/doc/version8.txt#L66
    " 2017-12-05: Whatever: The docs say setting a variable to the return
    " value should work, but this raises "E121: Undefined variable: call".
    "   let s:mode_timer = call timer_start(500, 's:TickleStatusLineMode')
    " I also tried = exe "call ..." but then 'exe' is said undefined.
    " I also tried using redir:
    "   redir => s:mode_timer
    "   ...
    "   redir END
    " but the variable remains unset.
    " So I'm really not sure what's up with that.
    " Also, without the 'call', timer_start raises:
    "   E492: Not an editor command: timer_start...
    " Whatever; we don't need the timer_id, I suppose; if we
    " don't cancel the timer (stop_timer), it's not a big deal.
    " Oh, and I could not get <SID> to work: 's:TickleStatusLineMode'
    " complains of not having script context, and <SID> unrecognized:
    "   call timer_start(125, 's:TickleStatusLineMode')
    "   call timer_start(125, <SID>.'TickleStatusLineMode')
    call timer_start(125, 'TickleStatusLineMode')
    "echom 'Skipping Statusline to avoid flashing.'
    return s:ModeFriendlyString(l:mode0)
  else
    return s:ModeFriendlyString(l:mode)
  endif
endfunction

" https://stackoverflow.com/questions/8383787/change-vims-linestatus-colors
"
" You need to define the colours as new highlighting groups User1, User2, etc:
"
" hi User1 ctermbg=blue    ctermfg=white   guibg=blue    guifg=white
" hi User2 ctermbg=black   ctermfg=red     guibg=black   guifg=red
"
" Then you can specify them in the statusline string like so:
"
" set statusline=
" set statusline+=%1*   " Switch to colour User1
" set statusline+=%F
" set statusline+=%*    " Switch to default colour
" set statusline+=%P
" set statusline+=%2*   " Switch to colour User2
" set statusline+=%c

" https://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
"1 set statusline=
"2 set statusline+=%#todo#  "switch to todo highlight
"3 set statusline+=%F       "full filename
"4 set statusline+=%#error# "switch to error highlight
"5 set statusline+=%y       "filetype
"6 set statusline+=%*       "switch back to normal statusline highlight
"7 set statusline+=%l       "line number

function ReallyAnnoying()
  echom 'fugitive#statusline(): ' . fugitive#statusline()
  echom 'matchstr: ' . matchstr(fugitive#statusline(),'(\zs.*\ze)')
  return matchstr(fugitive#statusline(),'(\zs.*\ze)')
endfunction

function! s:SetStatusLine(nr)

" FIXME: This function called a lot. Cache winnr and skip it set properly.

  let l:orig_nr = winnr()
  if a:nr > 0
    try
      execute a:nr . 'wincmd w'
    catch
      " Happens when searching and results scroll by.
      " E788: Not allowed to edit another buffer now
      " FIXME/2017-12-05: Isn't there a way to detect this??
      echom "Skip winnr: " . winnr()
      return
    endtry
  endif
  "if exists('w:airline_active')
  "  echom 'w:airline_active: ' . expand('%:t') . ' / ' . w:airline_active
  "else
  "  echom 'w:airline_active: ' . expand('%:t') . ' / Not defined'
  "endif

  let l:statline=''
  if a:nr == 0
    let l:statline .= "%9*"
    let l:statline .= "%2*%{SetStatusLineMode()}"
    " See: powerline/config_files/themes/powerline.json
    " I'm not sure what unicode that is...
    " 
    "let l:statline .= %9*%3*⮀
    let l:statline .= "%9*"
  endif
  " FIXME: Readonly: 
"					"fresh": "●",
"					"changed": "○"
"		"branch": {
"			"before": " "
"			"contents": " "
  let l:statline .= "%1*"
  let l:statline .= "%#StatusLine#"
  let l:statline .= "%{strlen(fugitive#statusline())>0?'\\ \\ ':''}"
  " WORKS: let l:statline .= "%{fugitive#statusline()}"
  " WORKS ON OWN: echo matchstr(fugitive#statusline(),'(\zs.*\ze)')
  "let l:statline .= '%{matchstr(fugitive#statusline(),"(\\zs.*i\\ze)")}'
  "let l:statline .= "%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}"
  "let l:statline .= "%{matchstr(fugitive#statusline(),'(.*)')}"
  "let l:statline .= "%.3{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}"
"  echom 'fugitive#statusline(): ' . fugitive#statusline()
"  echom 'matchstr: ' . matchstr(fugitive#statusline(),'(\zs.*\ze)')
  let l:statline .= '%{ReallyAnnoying()}'

  let l:statline .= "%{strlen(fugitive#statusline())>0?'\\ \\ ⮁\\ ':'\\ '}"

" FIXME: Use different widths for active window vs. not.
" FIXME: Consider strlen(fugitive#statusline()), too
" E.g., [Git(master)] -- so substract 7...
  let l:avail_width = winwidth(0) - 50
  "echom 'l:avail_width: ' . l:avail_width
  if l:avail_width > 0
    "let l:statline .= "%f\\ %{&ro?'⭤':''}%{&mod?'+':''}%<"
    let l:statline .= "%." . l:avail_width . "f\\ %{&ro?'⭤':''}%{&mod?'+':''}%<"
  endif


  let l:statline .= "%4*⮀"
  let l:statline .= "%#warningmsg#"
  let l:statline .= "%{SyntasticStatuslineFlag()}"
  if a:nr > 0
    let l:statline .= "%9*"
  endif
  let l:statline .= "%="                " split left-alighed and right-aligned
  let l:statline .= "%4*⮂"
  let l:statline .= "%#StatusLine#"
  let l:statline .= "\\ %{strlen(&fileformat)>0?&fileformat.'\\ ⮃\\ ':''}"
  let l:statline .= "%{strlen(&fileencoding)>0?&fileencoding.'\\ ⮃\\ ':''}"
  let l:statline .= "%{strlen(&filetype)>0?&filetype:''}"
  let l:statline .= "\\ %8*⮂"
  let l:statline .= "%7*\\ %p%%\\ "
  let l:statline .= "%6*⮂%5*⭡\\ \\ %l:%c\\ "

  "echom 'l:statline: ' . l:statline

  " WEIRD: If only one window open, calling setlocal doesn't do the trick.
  if winnr('$') == 1
    exe 'set statusline=' . l:statline
  else
    exe 'setlocal statusline=' . l:statline
  end


  " COPY THIS, sorta:
  " https://github.com/vim-airline/vim-airline
  " See also:
  " https://github.com/powerline/powerline

" 1 set statusline=%t       "tail of the filename
" 2 set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" 3 set statusline+=%{&ff}] "file format
" 4 set statusline+=%h      "help file flag
" 5 set statusline+=%m      "modified flag
" 6 set statusline+=%r      "read only flag
" 7 set statusline+=%y      "filetype
" 8 set statusline+=%=      "left/right separator
" 9 set statusline+=%c,     "cursor column
"10 set statusline+=%l/%L   "cursor line/total lines
"11 set statusline+=\ %P    "percent through file

" 1 set statusline=......%{FileSize()}.....
" 2 function! FileSize()
" 3     let bytes = getfsize(expand("%:p"))
" 4     if bytes <= 0
" 5         return ""
" 6     endif
" 7     if bytes < 1024
" 8         return bytes
" 9     else
"10         return (bytes / 1024) . "K"
"11     endif
"12 endfunction

"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%1*%=%5l%*             "current line
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4v\ %*             "virtual column number
"set statusline +=%2*0x%04B\ %*          "character under cursor

  if a:nr > 0
    execute l:orig_nr . "wincmd w"
  endif
endfunction

"set statusline=%2*%{Mode()}%3*⮀%1*%#StatusLine#%{strlen(fugitive#statusline())>0?'\ ⭠\ ':''}%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}%{strlen(fugitive#statusline())>0?'\ \ ⮁\ ':'\ '}%f\ %{&ro?'⭤':''}%{&mod?'+':''}%<%4*⮀%#warningmsg#%{SyntasticStatuslineFlag()}X____%=\ \ \ \ X%4*⮂%#StatusLine#\ %{strlen(&fileformat)>0?&fileformat.'\ ⮃\ ':''}%{strlen(&fileencoding)>0?&fileencoding.'\ ⮃\ ':''}%{strlen(&filetype)>0?&filetype:''}\ %8*⮂%7*\ %p%%\ %6*⮂%5*⭡\ \ %l:%c\ 

function s:StandUpStatusline()
  autocmd CmdwinEnter *
    \ | call <sid>on_window_changed()
  autocmd VimEnter,WinEnter,BufWinEnter,FileType,BufUnload *
    \ call <sid>on_window_changed()
  " NOTE: There does not seem to be an event for resizing splits,
  " just for resizing the entire Vim window. I even wrote to the
  " log and did not see any activity when dragging a split and
  " resizing two windows.
  "   gvim -V9myVim.log ~/.vim/bundle_/dubs_appearance/after/plugin/dubs_appearance.vim
  autocmd VimResized * :call <sid>on_window_changed()
endfunction
" Default statusline is empty string. Vim shows filepath, then [+] if dirty,
" followed by row,column and finally % through file.
"call <SID>StandUpStatusline()

let s:oldnr = -1
let s:omode = ''

function! s:on_window_changed()
  let l:curnr = winnr()
  if l:curnr == s:oldnr
    "echom 'Skipping Statusline for same window again.'
    return
  endif
  let s:oldnr = l:curnr

  for nr in filter(range(1, winnr('$')), 'v:val != winnr()')
    "call setwinvar(nr, 'airline_active', 0)
    "echom 'On inactive window: ' . nr . ' / ' . winbufnr(nr)
    call s:SetStatusLine(nr)
  endfor
  "echom 'getbufvar: ' . getbufvar(bufname("%"), "&buftype")
  "echom 'getbufvar: ' . &buftype
  "let w:airline_active = 1
  "echom 'On active window: ' . winnr() . ' / ' . winbufnr(0)
  call s:SetStatusLine(0)
endfunction

"call <SID>SetStatusLine()

"highlight StatusLine term=bold,reverse ctermfg=6 ctermbg=8 guifg=Yellow guibg=DarkGreen
"highlight StatusLineNC term=reverse ctermfg=7 ctermbg=1 guifg=LightGray guibg=DarkBlue
"highlight StatusLineTerm term=bold,reverse cterm=bold ctermfg=15 ctermbg=2 gui=bold guifg=bg guibg=DarkGreen
"highlight StatusLineTermNC term=reverse ctermfg=15 ctermbg=2 guifg=bg guibg=DarkGreen



