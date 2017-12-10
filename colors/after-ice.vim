" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.12.09
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Nighttime! Complete Vim highlight file
" License: GPLv3
" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" ----------------------------------------------------------------------------
" Copyright © 2017 Landon Bouma.
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

" User-tweakable settings.
"
" So far, just the background is tweakable.
"
" Obviously, you could just as easily copy
" this file and make your own color, so it
" does not aim to be very configurable.

if !exists("g:dubs_after_ice_background")
  let g:dubs_after_ice_background = "White"
endif

" NOTE: You can use common color names; see
"   :h cterm-colors
" or you can use #rrggbb colors for guifg and guibg
" (but not ctermfg or ctermbg).

function! s:Color__After_Ice__Set_Highlights()
  " Pretty Print
  " ------------------------------------------------------
  " Change the color of the line numbers
  " from deep red (default) to dark grey
  " (it's less abusive to the eye this way).
  highlight LineNr term=NONE cterm=NONE
    \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
    \ guifg=DarkGrey guibg=NONE

  " 2012.09.21: Add colors for :list. See :h listchars. You can show whitespace.
  " Hmmm, the trail:~ puts tildes after the last line number... kinda weird lookn
  " set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
  highlight SpecialKey term=NONE cterm=NONE
    \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
    \ guifg=DarkGrey guibg=NONE

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
  " FIXME: 2012.09.21: This isn't working from here: you can manually
  " :set list and then :highlight... and the whitespace chars are shown
  " in the same gray as the line numbers, but if you just :set list, the
  " whitespace chars don't appear, even with the same highlight here....
  highlight NonText term=NONE cterm=NONE
    \ ctermfg=DarkGrey ctermbg=NONE gui=NONE
    \ guifg=DarkGrey guibg=NONE
  ":highlight NonText term=NONE cterm=NONE
  "  \ ctermfg=DarkGrey ctermbg=NONE
  "  \ gui=NONE guifg=DarkGrey guibg=NONE
  "highlight NonText guifg=White

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

  highlight StatusLine term=bold,reverse gui=NONE
    \ guifg=Yellow guibg=DarkGray
    \ cterm=NONE ctermfg=Yellow ctermbg=DarkGray

  highlight StatusLineNC term=reverse gui=NONE
    \ guifg=White guibg=DarkGray
    \ ctermfg=White ctermbg=DarkGray

  " Between two windows that are vertically split, there are
  " black rectangles with white bars inside. Make the vertical
  " tab characters to be white on white, hiding them.
  highlight VertSplit term=reverse gui=NONE
    \ guifg=White guibg=White
    \ ctermfg=White ctermbg=White

  " Change Search highlight
  " Vim's default.
  highlight Search term=reverse
    \ guibg=LightGreen
    \ ctermfg=0 ctermbg=3
  "highlight Search guibg=Green
  "highlight Search guibg=LightGreen

  " Highlight columns color.
  " I use this to help me manually wrap long lines (when not using parT).
  " 2014.11.18: [lb] happened to load the "Highlight long lines" page
  "   on Wikia <http://vim.wikia.com/wiki/Highlight_long_lines> and
  "   thankfully I found out Vim 7.3 includes a newer, better way to
  "   highlight line length!
  " See also in the syle plugin
  "   https://github.com/landonb/dubs_style_guard
  " e.g., `set colorcolumn=77,78,79`.
  " The default color is a lightish pink, which is kinda atrocious.
  highlight ColorColumn guibg=lightgrey ctermbg=lightgrey

  " ErrorMsg defaults to
  "  xxx term=standout ctermfg=15 ctermbg=4 guifg=White guibg=Red
  " For color reference see :h cterm-colors
  " Here's the list of light colors:
  "  LightRed LightGreen LightCyan LightMagenta LightYellow LightGray
  " [lb] tried Red and LightRed but red is too loud and obnoxious.
  " So then I just tried LightBlue and it seems to fit in nicely.
  highlight MyErrorMsg term=standout ctermfg=15 ctermbg=4 guibg=LightBlue
endfunction

function! s:Color__After_Ice__Main()
  if has('termguicolors')
    set termguicolors
  endif
  " FIXME/2017-12-09: Are termguicolors and t_Co related?
  "   Should I add t_Co to after-dark?
  " Vim's default.
  " 2017-11-12: WTF: White isn't really white, it's same as LightGray.
  " This could be because Vim isn't really tapped into the terminal
  " colors (they're an approximation) or because Vim is saving us from
  " having trouble seeing white text (should a syntax highlighter use
  " white).
  " Or maybe we need to set t_Co? Under :h terminal-options, "number of colors".
  set t_Co=256

  highlight clear
  "colorscheme default

"  set background=dark
  set background=light
  
  exe 'highlight Normal gui=NONE '
    \ 'guifg=Black guibg=' . g:dubs_after_ice_background
    \ 'ctermfg=Black ctermbg=' . g:dubs_after_ice_background

  " Set the remaining highlights.
  call s:Color__After_Ice__Set_Highlights()
endfunction

call <SID>Color__After_Ice__Main()

