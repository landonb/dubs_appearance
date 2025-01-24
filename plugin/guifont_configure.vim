" Dubs Vim guifont setting.
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/dubs_appearance#💅
" License: https://creativecommons.org/publicdomain/zero/1.0/

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_dubs_appearance_guifont_configure
endif

if exists('g:loaded_dubs_appearance_guifont_configure') || &cp

  finish
endif

let g:loaded_dubs_appearance_guifont_configure = 1

" -------------------------------------------------------------------

" REFER: Rebuild Linux font cache after mucking around with ~/.fonts files:
"
"   $ sudo fc-cache -fv

" REFER: On macOS or Win32, open an OS GUI font picker:
"
"   :set guifont=*
"
" - Hint: Use font picker to set font, then `echo &guifont`
"   (or `set guifont?`) and copy-paste the result below.

" -------------------------------------------------------------------

" HSTRY: This plugin has been Proudly Hack'ing since Aug 17, 2015.
" - 2022-09-21: Changed to Hack Nerd Font, for the extra glyths.
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

" -------------------------------------------------------------------

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
  if has('nvim')
    set guifont=Hack\ Nerd\ Font\ Mono,Monaco,Courier\ New:h12
  else
    set guifont=Hack\ Nerd\ Font\ Mono:h12,Monaco:h11,Courier\ New:h12
  endif
endfunction

" -------------------------------------------------------------------

" BWARE/2022-09-21: The author runs GTK personally, and macOS professionally.
" - I haven't tested any of the other paths, at least not in years.
"   - I couldn't even tell you where the `gui_photon` check came from.
"     And when I searched gui_photon / Photon GUI, I was like, Huh?
"     So I'm not sure where `has("gui_photon")` came from; I must've
"     copied that from some other plugin years ago.
"     - But I'm keeping it! For posterity. It's the only place in all
"       my plugins that I call it, so it's kind of a novelty.

function! s:GuiSetFont()
  if ! has("gui_running")

    return
  endif

  if has("gui_gtk2") || has("gui_gtk3")
    call s:SetFontHack_GTK()
  elseif has("macunix")
    call s:SetFontHack_macOS()
  else
    echom 'ALERT: Unrecognized Vim environment: Not setting guifont'
  endif

  " ALTLY— Albeit untested paths:
  "
  "   elseif has("gui_photon")
  "     set guifont=Courier\ New:s9
  "   elseif has("gui_kde")
  "     set guifont=Courier\ New/9/-1/5/50/0/0/0/1/0
  "   elseif has("x11")
  "     set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  "   elseif has("win16") || has("win32") || has("win64")
  "     set guifont=Courier_New:h9
  "   else
  "     set guifont=Courier_New:h9:cDEFAULT
  "   endif
endfunction

call s:GuiSetFont()

