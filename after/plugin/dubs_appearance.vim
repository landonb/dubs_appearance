" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.04.03
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: After-script for dubs_appearance, to fix `behave msvin` issue.
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

if exists("g:plugin_dubs_appearance_after") || &cp
  finish
endif
let g:plugin_dubs_appearance_after = 1

" See what OS we're on
" ------------------------------------------------------
let s:running_windows = has("win16") || has("win32") || has("win64")

" So-called MS Windows mode
" ------------------------------------------------------
" 2017-04-03: In Insert mode, at work, Ctrl-X is now inserting "+x -- what the hell.
"  I didn't change anything, I swear!
if !s:running_windows
  " :echom "XXXXXXXXXXXXXXXXXXXXXXXXXXX SOURCED ". $VIMRUNTIME . "/mswin.vim"
  "  /usr/share/vim/vim74/mswin.vim
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif

