" Dubs Vim search-related settings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_search_smartening") || &cp
  finish
endif
let g:loaded_search_smartening = 1

" Search Behavior
" ------------------------------------------------------
" Case-insensitive searches
" 2012.07.15: My old comment says,
"               NOTE /You can override this with/I
"             But it's really \c or \C that you want,
"               /\CCase Sensitive Incremental Search
"             You can put the '\C' wherever you want.
"             (The \c does lowercase, \CDUH.)
"             See :h ignorecase
set ignorecase
" Better yet, search case sensitive if the
" search term contains a capital letter
set smartcase
" These should be set by default:
"   set hlsearch  " Highlight search terms
"   set incsearch " search dynamically as keyword is typed
" but on my Ubuntu box, unlike Windows, they're not, so
set hlsearch  " Highlight search terms
set incsearch " search dynamically as keyword is typed

