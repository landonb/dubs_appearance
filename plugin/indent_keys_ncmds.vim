" Dubs Vim indent-related settings.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_indent_keys_ncmds") || &cp
  finish
endif
let g:loaded_indent_keys_ncmds = 1

" Drop a Deuce on that Tab
" ------------------------------------------------------
" See CycleThruStyleGuides for intelligent tab settings,
" or use a modeline. Or let Vim figure it out, i.e., do
" not mess up style for :help docs. And no to elastic tabs.
"set expandtab
"set tabstop=2
"set shiftwidth=2
"
" Honor file header and footer modelines, e.g.,
"   vim:tw=78:ts=8:ft=help:norl:
"   vim:tw=0:ts=2:sw=2:et:norl:ft=vim
"   etc.
" MAYBE/2017-11-04: Can this be disabled because CycleThruStyleGuides_FixMatch?
"   Things work well as is, so no point to answer.
set modeline

set autoindent

" smartindent is too smart and doesn't
" indent lines that look like C macros,
" i.e., those that start with an octothorpe;
" if you hit return, get an indent, type '#',
" smartindent moves the pound to the start of
" the line (this might just be with .py files,
" not sure...)
" set smartindent
" FIXME 2011.01.17 I think this problem no longer happens...
"       so setting smartindent instead
"set nosmartindent
set smartindent

"set smarttab

" ------------------------------------------------------
" Auto-indent selected code
" ------------------------------------------------------

" SEE INSTEAD: Select code, <Ctrl-O>= fixes code indenting (auto-indents).
" [lb] doesn't use this fcnality, ever.

" ------------------------------------------------------
" Auto-indent selected code
" ------------------------------------------------------

" Switch on cindent automatically for all files.
" 2017-06-27: See possibly comments in filetype.vim.
" - :help filetype-indent-on
"   "Enable loading the indent file for specific file types."
" FIXME/2017-12-10: Do you actually use any indent files?
filetype indent on

" ------------------------------------------------------
" Fiddle with smart indent settings
" ------------------------------------------------------

" FIXME/2017-12-10: This belongs in a filetype-specific indent/ file.
" FIXME/2017-06-27: This is a very moldy comment. Meh:
"   FIXME: Applies just to Python, maybe others
"   EXPLAIN: You removed colons: because...?
"   because in Python it causes an auto-indent?
"   But I still have problems when I type : in python:
"     it still reformats my line. So I assume these sets
"     are in vain.
"   :set cinkeys=0{,0},0),:,!^F,o,O,e
set cinkeys=0{,0},0),!^F,o,O,e
" :set indentkeys=0{,0},:,!^F,o,O,e,<:>,=elif,=except
set indentkeys=0{,0},!^F,o,O,e,<:>,=elif,=except

" Read about "Contextual Indent", i.e., why to do write code like,
"
"   my function(arg1,
"               arg2,
"               ...)
"
"  http://milan.adamovsky.com/2010/08/contextual-indent.html

