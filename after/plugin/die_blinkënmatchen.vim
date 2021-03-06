" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Basic Vim configuration (no functions; just settings and mappings)
" License: GPLv3
" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" ----------------------------------------------------------------------------
" Copyright © 2017 Landon Bouma.
"
" This file is part of Dubs Vim.
"
" Dubs Vim is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation, either version
" 3 of the License, or (at your option) any later version.
"
" Dubs Vim is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty
" of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
" the GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with Dubs Vim. If not, see <http://www.gnu.org/licenses/>
" or write Free Software Foundation, Inc., 51 Franklin Street,
"                     Fifth Floor, Boston, MA 02110-1301, USA.
" ===================================================================

if exists("g:plugin_die_blinkenmatchen") || &cp
  finish
endif
let g:plugin_die_blinkenmatchen = 1

" Modified version
"   of Rich's modified version
"   of Damian Conway's search highlight blinker,
"     Die Blinkënmatchen.

" https://vi.stackexchange.com/questions/8851/interrupting-blink-highlighting-function-if-mapping-is-invoked-again/13551#13551

" 2018-06-11: See also another plugin that highlights search results
" as you jump to them, and also clears the highlight when you move the
" cursor. Except it conflicts with this code (I'm assuming; it conflicts
" with something in Dubs Vim; or it's just broken), and the code is longer
" and more complicated looking than I want to spend time stealing from.
"   https://github.com/pgdouyon/vim-evanesco
" However, I still like the idea of clearing the highlight automatically
" if you cursor away from a match... seems like something tidy I might
" enjoy (though it's hard to know for sure without enabling such a
" feature any playing around with it; for now, without that feature,
" just Ctrl-H to clear highlights, as appropriate).

" The length of each blink in milliseconds. If you want an interruptible
" non-blinking highlight, set this to match s:blink_length.
let s:blink_freq = 125

" How long to blink the match text, in milliseconds. On Vim <8, without
" +timers, you need a much shorter blink time because Vim blocks while
" it waits for the blink to complete.
"let s:blink_length = has('timers') ? 500 : 100
"let s:blink_length = has('timers') ? 1500 : 100
let s:blink_length = has('timers') ? float2nr(s:blink_freq * 1.5) : 100

"let s:use_highlight = 'ErrorMsg'
let s:use_highlight = 'DiffChange'

if has('timers')
  let s:blink_match_id = 0
  let s:blink_timer_id = 0
  let s:blink_stop_id = 0

  " Toggle the blink highlight. This is called many times
  " repeatedly in order to create the blinking effect.
  function! BlinkToggle(timer_id)
    if s:blink_match_id > 0
      " Clear highlight
      call BlinkClear()
    else
      " Set highlight
      let s:blink_match_id = matchadd(s:use_highlight, s:target_pat, 101)
      redraw
    endif
  endfunction

  " Remove the blink highlight.
  function! BlinkClear()
    call matchdelete(s:blink_match_id)
    let s:blink_match_id = 0
    redraw
  endfunction

  let s:skip_first = 0
  " Stop blinking
  "
  " Cancels all the timers and removes the highlight if necessary.
  function! BlinkStop(timer_id)
    if s:skip_first > 0
        let s:skip_first -= 1
        return
    endif
    " Cancel timers
    if s:blink_timer_id > 0
      " 2017-12-10: If you search in quickfix and then, while a
      " blink is happening, you <S-M-Up> outta there, you'll see:
      "   E803: Id not found: nn
      " so try-catch, and get on with life.
      try
        call timer_stop(s:blink_timer_id)
      catch
        " pass
      endtry
      let s:blink_timer_id = 0
    endif
    if s:blink_stop_id > 0
      try
        call timer_stop(s:blink_stop_id)
      catch
        " pass
      endtry
      let s:blink_stop_id = 0
    endif
    " And clear blink highlight.
    if s:blink_match_id > 0
      call BlinkClear()
    endif
  endfunction

  augroup die_blinkmatchen
    autocmd!
    autocmd CursorMoved * call BlinkStop(0)
    autocmd InsertEnter * call BlinkStop(0)
  augroup END
endif

function! HLNext(blink_length, blink_freq, skip_first)
  let s:target_pat = '\c\%#'.@/
  let s:skip_first = a:skip_first
  if has("timers")
    " Reset any existing blinks.
    call BlinkStop(0)
    " Start blinking. It is necessary to call this now so that the match
    " is highlighted initially (in case of large values of a:blink_freq).
    call BlinkToggle(0)
    " Set up blink timers.
    let s:blink_timer_id = timer_start(a:blink_freq, 'BlinkToggle', {'repeat': -1})
    let s:blink_stop_id = timer_start(a:blink_length, 'BlinkStop')
  else
    " Vim doesn't have the +timers feature.
    " Use Conway's original code.
    " Highlight the match.
    let ring = matchadd(s:use_highlight, s:target_pat, 101)
    redraw
    " Wait.
    exec 'sleep ' . a:blink_length . 'm'
    " Remove the highlight.
    call matchdelete(ring)
    redraw
  endif
endfunction

" Set up maps for n and N that blink the match
" 2018-07-09: (lb): Giving 'zz' a shot.
execute printf(
  \ 'nnoremap <silent> n nzz:call HLNext(%d, %d, 0)<cr>',
  \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
execute printf(
  \ 'nnoremap <silent> N Nzz:call HLNext(%d, %d, 0)<cr>',
  \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)

" <F3> overrides of github.com/landonb/dubs_edit_juice

if exists("g:plugin_edit_juice_vim") && g:plugin_edit_juice_vim == 1
  " Remap dubs_edit_juice <F3> variants.
  execute printf(
    \ 'noremap <silent> <F3> /<CR>:call HLNext(%d, %d, 0)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
  execute printf(
    \ 'inoremap <silent> <F3> <C-O>/<CR><C-O>:call HLNext(%d, %d, 2)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
  execute printf(
    \ 'vnoremap <silent> <F3> :<C-U><CR>gvygV/<C-R>"<CR>:call HLNext(%d, %d, 0)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)

  " Remap dubs_edit_juice <S-F3> variants.
  execute printf(
    \ 'noremap <silent> <S-F3> ?<CR>:call HLNext(%d, %d, 0)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
  execute printf(
    \ 'inoremap <silent> <S-F3> <C-O>?<CR><C-O>:call HLNext(%d, %d, 2)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
  execute printf(
    \ 'vnoremap <silent> <S-F3> :<C-U><CR>gvygV?<C-R>"<CR>?<CR>:call HLNext(%d, %d, 0)<CR>',
    \ s:blink_length, has('timers') ? s:blink_freq : s:blink_length)
endif

