" Dubs Vim UX settings and mappings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_guifont_configure") || &cp
  finish
endif
let g:loaded_guifont_configure = 1

" See what OS we're on
" ------------------------------------------------------
let s:running_windows = has("win16") || has("win32") || has("win64")

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Font
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Hack Regular 9. Proudly using since Aug 17, 2015.
" ------------------------------------------------------------------------
function! s:SetFontHack_GTK()
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

function! s:SetFontHack_macOS()
  " SETUP/2020-08-31 22:46:
  "   brew install --cask homebrew/cask-fonts/font-hack-nerd-font
  if len(glob($HOME . "/Library/Fonts/Hack Regular Nerd Font Complete.ttf")) > 0
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h12
    " NOTE: I did not see a difference with the 'Mono' variety, e.g.:
    "   if len(glob($HOME . "/Library/Fonts/Hack Regular Nerd Font Complete Mono.ttf")) > 0
    "     set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ Mono:h12
  else
    set guifont=Courier_New:h12
  endif
endfunction

function! s:GuiSetFont()
  if ! has("gui_running") | return | endif
  " MAYBE/2018-12-24: Make the font more easily themeable.
  "   For now, being opinionated: You should install Hack!
  "   Otherwise, I'll settle for Courier New 9, 'snot bad.
  "   - See also Fira Code, if you like, e.g., "≥" done easy.
  " From http://vim.wikia.com/wiki/VimTip632
  if has("gui_gtk2") || has("gui_gtk3")
    call s:SetFontHack_GTK()
  elseif has("macunix")
    call s:SetFontHack_macOS()
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

