" Dubs Vim guifont setting.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_guifont_configure") || &cp
  finish
endif
let g:loaded_guifont_configure = 1

" SETUP/2022-09-21:
" - Linux users:
"   - The font paths below assume that you downloaded and unpacked Hack
"     or Hack Nerd Font archives to ~/.fonts/ and did not otherwise change
"     path names.
"     - CXREF: The author uses an Ansible playbook to install said font:
"       https://github.com/landonb/zoidy_apps_et_al/blob/release/tasks/font-hack-nerd-font.yml
" - macOS users:
"     brew install --cask homebrew/cask-fonts/font-hack-nerd-font

" -------

" "Hack Regular 9": Proudly Hack'ing since Aug 17, 2015.
" - 2022-09-21: On Linux, I've since changed from 'Hack Regular 9'
"   to 'Hack Nerd Font Mono 9, which is the same beloved Hack, plus Extras.
"   - Though, TBH, I'm not sure the Extras matter. Hack covers all the
"     regular text characters you'll see in Vim. (And if you want the
"     latest emoji, install *Noto Emoji* (though you don't tell Vim about
"     Noto Emoji; you just install it to ~/.fonts, and Vim'll use it).)
"     - And while I'm not sure where the Powerline glyphs come from,
"       they look the same for me, whether
"         `guifont=Hack\ Regular\ 9`, or
"         `guifont=Hack\ Nerd\ Font\ Mono\ 9`.
"     - So, basically, whether 'Hack Regular 9' or 'Hack Nerd Font Mono 9',
"       you'll be happy!
"   - SAVVY: Rebuild font cache after mucking around with ~/.fonts files:
"       $ sudo fc-cache -fv

function! s:SetFontHack_GTK()
  if len(glob($HOME . "/.fonts/Hack/Hack Regular Nerd Font Complete Mono.ttf")) > 0
    set guifont=Hack\ Nerd\ Font\ Mono\ 9
  elseif len(glob($HOME . "/.fonts/Hack-v*-ttf/ttf/Hack-Regular.ttf")) > 0
    set guifont=Hack\ Regular\ 9
  else
    set guifont=Courier\ New\ 9
  endif
endfunction

function! s:SetFontHack_macOS()
  if len(glob($HOME . "/Library/Fonts/Hack Regular Nerd Font Complete.ttf")) > 0
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h12
    " NOTE: I did not see a difference with the 'Mono' variety, e.g.:
    "   if len(glob($HOME . "/Library/Fonts/Hack Regular Nerd Font Complete Mono.ttf")) > 0
    "     set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ Mono:h12
  else
    set guifont=Courier_New:h12
  endif
endfunction

" 2022-09-21: Here's some Windows code, albeit most likely outdated.
" - This plugin was developed first on Windows, using Cygwin (over a
"   decade ago!), but the author has since (since 2014) migrated to
"   Linux Mint (and never looked back; except I use macOS for work).
" - So I've disabled my Windows-compatible code, but I haven't removed
"   it yet. (Though in terms of technical debt, I should.)
" - But for posterity, and in case anyone asks for Windows support,
"   here's what it looked like, though I'm guessing that it would be
"   different nowadays, considering the since-added
"   *Windows Subsystem for Linux*:
"
"     let s:running_windows = has("win16") || has("win32") || has("win64")
"     ...
"     if s:running_windows
"       set guifont=Courier_New:h9
"     ...
"
"   and I'm guessing you'd want to install Hack for Windows. B/c Hack rules.

" BWARE/2022-09-21: The author runs GTK personally, and macOS professionally.
" - I haven't tested any of the other paths, at least not in years.
"   - I couldn't even tell you where the `gui_photon` check came from.
"     And when I searched gui_photon / Photon GUI, I was like, Huh?
"     So I'm not sure where `has("gui_photon")` came from; I must've
"     copied that from some other plugin years ago.
"     - But I'm keeping it! For posterity. It's the only place in all
"       my plugins that I call it, so it's kind of a novelty.

function! s:GuiSetFont()
  if ! has("gui_running") | return | endif

  if has("gui_gtk2") || has("gui_gtk3")
    call s:SetFontHack_GTK()
  elseif has("macunix")
    call s:SetFontHack_macOS()
  elseif has("gui_photon")
    " BWARE/2022-09-21: Untested path.
    set guifont=Courier\ New:s9
  elseif has("gui_kde")
    " BWARE/2022-09-21: Untested path.
    set guifont=Courier\ New/9/-1/5/50/0/0/0/1/0
  elseif has("x11")
    " BWARE/2022-09-21: Untested path.
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    " BWARE/2022-09-21: Untested path.
    set guifont=Courier_New:h9:cDEFAULT
  endif
endfunction

call s:GuiSetFont()

