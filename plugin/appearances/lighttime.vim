" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.12.01
" Project Page: https://github.com/landonb/dubs_appearance
" Summary: Lighttime! Complete Vim highlight file
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

" SYNC_ME: Until the steps below are further automated, this comment
"   is shared with all other theme files. [2017-12-01: Which is just 2!]

" To generate the contents of the function herein:
"
" 1. Run
"
"   :TabMessage highlight
"
" 2. Copy that output and paste it into the function
"    block, below, overwriting everything else.
"
" 3. Regex it:
"
"   :.,$s/^\([^ ]\+\) \+xxx \(.*\)$/:highlight \1 \2/gc
"
"   MAYBE/2017-12-01: I couldn't get [^\s] to work: it finds not "s" or "S"!
"
" 4. Fix all the "links to" lines:
"
"   :.,$s/^\s\+:highlight \([a-zA-Z0-9]\+\) links to \([a-zA-Z0-9]\+\)$/:highlight link \1 \2/gc
"
" 5. Fix all the "cleared" lines:
"
"   :.,$s/^\s\+:highlight \([a-zA-Z0-9]\+\) cleared$/:highlight clear \1/gc
"
" 6. Remove what's after "font=", because if it contains spaces,
"    even delimiting them with "\" doesn't fix the line. E.g.,
"      E416: missing equal sign: Regular 9
"    and
"      E416: missing equal sign: Regular\ 9
"    when font=Hack Regular 9
"      and
"    when font=Hack\ Regular\ 9
"
"   :.,$s/ font=\([a-zA-Z0-9]\+\(\( \|$\)\)\)\+//gc
"
" 7. Tab indent, IYW.

if exists("g:plugin_dubs_appearance__appearances__lighttime") || &cp
  finish
endif
let g:plugin_dubs_appearance__appearances__lighttime = 1

function g:Theme_Highlight_Lighttime()
  :highlight SpecialKey ctermfg=242 guifg=DarkGrey
  :highlight link EndOfBuffer NonText
  :highlight NonText ctermfg=242 guifg=DarkGrey
  :highlight Directory term=bold ctermfg=4 guifg=Blue
  :highlight ErrorMsg term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
  :highlight IncSearch term=reverse cterm=reverse gui=reverse
  :highlight Search term=reverse ctermfg=0 ctermbg=3 guibg=LightGreen
  :highlight MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
  :highlight ModeMsg term=bold cterm=bold gui=bold
  :highlight LineNr ctermfg=242 guifg=DarkGrey
  :highlight CursorLineNr term=bold ctermfg=130 gui=bold guifg=Brown
  :highlight Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
  :highlight StatusLine term=bold,reverse ctermfg=11 ctermbg=242 guifg=Yellow guibg=DarkGray
  :highlight StatusLineNC term=reverse cterm=reverse ctermfg=15 ctermbg=242 guifg=White guibg=DarkGray
  :highlight VertSplit term=reverse cterm=reverse ctermfg=15 ctermbg=15 guifg=White guibg=White
  :highlight Title term=bold ctermfg=5 gui=bold guifg=Magenta
  :highlight Visual term=reverse ctermbg=7 guibg=LightGrey
  :highlight VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
  :highlight WarningMsg term=standout ctermfg=1 guifg=Red
  :highlight WildMenu term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
  :highlight Folded term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=LightGrey
  :highlight FoldColumn term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
  :highlight DiffAdd term=bold ctermbg=81 guibg=LightBlue
  :highlight DiffChange term=bold ctermbg=225 guibg=LightMagenta
  :highlight DiffDelete term=bold ctermfg=12 ctermbg=159 gui=bold guifg=Blue guibg=LightCyan
  :highlight DiffText term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red
  :highlight SignColumn term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
  :highlight Conceal ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
  :highlight SpellBad term=reverse ctermbg=224 cterm=undercurl gui=undercurl guibg=NONE guisp=Red
  :highlight SpellCap term=reverse ctermbg=81 cterm=undercurl gui=undercurl guibg=NONE guisp=Blue
  :highlight SpellRare term=reverse ctermbg=225 cterm=undercurl gui=undercurl guibg=NONE guisp=Magenta
  :highlight SpellLocal term=underline ctermbg=14 cterm=undercurl gui=undercurl guibg=NONE guisp=DarkCyan
  :highlight Pmenu ctermfg=0 ctermbg=225 guibg=LightMagenta
  :highlight PmenuSel ctermfg=0 ctermbg=7 guibg=Grey
  :highlight PmenuSbar ctermbg=248 guibg=Grey
  :highlight PmenuThumb ctermbg=0 guibg=Black
  :highlight TabLine term=underline cterm=underline ctermfg=0 ctermbg=7 gui=underline guibg=LightGrey
  :highlight TabLineSel term=bold cterm=bold gui=bold
  :highlight TabLineFill term=reverse cterm=reverse gui=reverse
  :highlight CursorColumn term=reverse ctermbg=7 guibg=Grey90
  :highlight CursorLine term=underline cterm=underline guibg=Grey90
  :highlight ColorColumn term=reverse ctermbg=7 guibg=lightgrey
  :highlight link QuickFixLine Search
  :highlight StatusLineTerm term=bold,reverse cterm=bold ctermfg=15 ctermbg=2 gui=bold guifg=bg guibg=DarkGreen
  :highlight StatusLineTermNC term=reverse ctermfg=15 ctermbg=2 guifg=bg guibg=DarkGreen
  :highlight Cursor guifg=bg guibg=fg
  :highlight lCursor guifg=bg guibg=fg
  :highlight MatchParen term=reverse ctermbg=14 guibg=Cyan
  :highlight Normal ctermfg=0 ctermbg=15 guifg=Black guibg=White
  :highlight ToolbarLine term=underline ctermbg=7 guibg=LightGrey
  :highlight ToolbarButton cterm=bold ctermfg=15 ctermbg=242 gui=bold guifg=White guibg=Grey40
  :highlight Comment term=bold ctermfg=4 guifg=Blue
  :highlight Constant term=underline ctermfg=1 guifg=Magenta
  :highlight Special term=bold ctermfg=5 guifg=SlateBlue
  :highlight Identifier term=underline ctermfg=6 guifg=DarkCyan
  :highlight Statement term=bold ctermfg=130 gui=bold guifg=Brown
  :highlight PreProc term=underline ctermfg=5 guifg=Purple
  :highlight Type term=underline ctermfg=2 gui=bold guifg=SeaGreen
  :highlight Underlined term=underline cterm=underline ctermfg=5 gui=underline guifg=SlateBlue
  :highlight Ignore ctermfg=15 guifg=bg
  :highlight Error term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
  :highlight Todo term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
  :highlight link String Constant
  :highlight link Character Constant
  :highlight link Number Constant
  :highlight link Boolean Constant
  :highlight link Float Number
  :highlight link Function Identifier
  :highlight link Conditional Statement
  :highlight link Repeat Statement
  :highlight link Label Statement
  :highlight link Operator Statement
  :highlight link Keyword Statement
  :highlight link Exception Statement
  :highlight link Include PreProc
  :highlight link Define PreProc
  :highlight link Macro PreProc
  :highlight link PreCondit PreProc
  :highlight link StorageClass Type
  :highlight link Structure Type
  :highlight link Typedef Type
  :highlight link Tag Special
  :highlight link SpecialChar Special
  :highlight link Delimiter Special
  :highlight link SpecialComment Special
  :highlight link Debug Special
  :highlight MyErrorMsg term=standout ctermfg=15 ctermbg=4 guibg=LightBlue
  :highlight link SyntasticError SpellBad
  :highlight link SyntasticWarning SpellCap
  :highlight link SyntasticStyleError SyntasticError
  :highlight link SyntasticStyleWarning SyntasticWarning
  :highlight link GPGWarning WarningMsg
  :highlight link GPGError ErrorMsg
  :highlight link GPGHighlightUnknownRecipient ErrorMsg
  :highlight link vimTodo Todo
  :highlight link vimCommand Statement
  :highlight clear vimStdPlugin
  :highlight link vimOption PreProc
  :highlight link vimErrSetting vimError
  :highlight link vimAutoEvent Type
  :highlight link vimGroup Type
  :highlight link vimHLGroup vimGroup
  :highlight link vimFuncName Function
  :highlight clear vimGlobal
  :highlight link vimSubst vimCommand
  :highlight link vimNumber Number
  :highlight link vimAddress vimMark
  :highlight link vimAutoCmd vimCommand
  :highlight clear vimIsCommand
  :highlight clear vimExtCmd
  :highlight clear vimFilter
  :highlight link vimLet vimCommand
  :highlight link vimMap vimCommand
  :highlight link vimMark Number
  :highlight clear vimSet
  :highlight link vimSyntax vimCommand
  :highlight clear vimUserCmd
  :highlight clear vimCmdSep
  :highlight link vimVar Identifier
  :highlight link vimFBVar vimVar
  :highlight link vimInsert vimString
  :highlight link vimBehaveModel vimBehave
  :highlight link vimBehaveError vimError
  :highlight link vimBehave vimCommand
  :highlight link vimFTCmd vimCommand
  :highlight link vimFTOption vimSynType
  :highlight link vimFTError vimError
  :highlight clear vimFiletype
  :highlight clear vimAugroup
  :highlight clear vimExecute
  :highlight link vimNotFunc vimCommand
  :highlight clear vimFunction
  :highlight link vimFunctionError vimError
  :highlight link vimLineComment vimComment
  :highlight link vimSpecFile Identifier
  :highlight link vimOper Operator
  :highlight clear vimOperParen
  :highlight link vimComment Comment
  :highlight link vimString String
  :highlight link vimRegister SpecialChar
  :highlight link vimCmplxRepeat SpecialChar
  :highlight clear vimRegion
  :highlight clear vimSynLine
  :highlight link vimNotation Special
  :highlight link vimCtrlChar SpecialChar
  :highlight link vimFuncVar Identifier
  :highlight link vimContinue Special
  :highlight link vimAugroupKey vimCommand
  :highlight link vimAugroupError vimError
  :highlight link vimEnvvar PreProc
  :highlight link vimFunc vimError
  :highlight link vimParenSep Delimiter
  :highlight link vimSep Delimiter
  :highlight link vimOperError Error
  :highlight link vimFuncKey vimCommand
  :highlight link vimFuncSID Special
  :highlight link vimAbb vimCommand
  :highlight clear vimEcho
  :highlight link vimEchoHL vimCommand
  :highlight clear vimIf
  :highlight link vimHighlight vimCommand
  :highlight link vimNorm vimCommand
  :highlight link vimUnmap vimMap
  :highlight link vimUserCommand vimCommand
  :highlight clear vimFuncBody
  :highlight clear vimFuncBlank
  :highlight link vimPattern Type
  :highlight link vimSpecFileMod vimSpecFile
  :highlight clear vimEscapeBrace
  :highlight clear vimSetEqual
  :highlight link vimSetString vimString
  :highlight clear vimSubstRep
  :highlight clear vimSubstRange
  :highlight link vimUserAttrb vimSpecial
  :highlight link vimUserAttrbError Error
  :highlight link vimUserAttrbKey vimOption
  :highlight link vimUserAttrbCmplt vimSpecial
  :highlight link vimUserCmdError Error
  :highlight link vimUserAttrbCmpltFunc Special
  :highlight link vimCommentString vimString
  :highlight link vimPatSepErr vimPatSep
  :highlight link vimPatSep SpecialChar
  :highlight link vimPatSepZ vimPatSep
  :highlight link vimPatSepZone vimString
  :highlight link vimPatSepR vimPatSep
  :highlight clear vimPatRegion
  :highlight link vimNotPatSep vimString
  :highlight link vimStringCont vimString
  :highlight link vimSubstTwoBS vimString
  :highlight link vimSubstSubstr SpecialChar
  :highlight clear vimCollection
  :highlight clear vimSubstPat
  :highlight link vimSubst1 vimSubst
  :highlight link vimSubstDelim Delimiter
  :highlight clear vimSubstRep4
  :highlight link vimSubstFlagErr vimError
  :highlight clear vimCollClass
  :highlight link vimCollClassErr vimError
  :highlight link vimSubstFlags Special
  :highlight link vimMarkNumber vimNumber
  :highlight link vimPlainMark vimMark
  :highlight link vimPlainRegister vimRegister
  :highlight link vimSetMod vimOption
  :highlight link vimSetSep Statement
  :highlight link vimMapMod vimBracket
  :highlight clear vimMapLhs
  :highlight clear vimAutoCmdSpace
  :highlight clear vimAutoEventList
  :highlight clear vimAutoCmdSfxList
  :highlight link vimEchoHLNone vimGroup
  :highlight link vimMapBang vimCommand
  :highlight clear vimMapRhs
  :highlight link vimMapModKey vimFuncSID
  :highlight link vimMapModErr vimError
  :highlight clear vimMapRhsExtend
  :highlight clear vimMenuBang
  :highlight clear vimMenuPriority
  :highlight link vimMenuName PreProc
  :highlight link vimMenuMod vimMapMod
  :highlight link vimMenuNameMore vimMenuName
  :highlight clear vimMenuMap
  :highlight clear vimMenuRhs
  :highlight link vimBracket Delimiter
  :highlight link vimUserFunc Normal
  :highlight link vimElseIfErr Error
  :highlight link vimBufnrWarn vimWarn
  :highlight clear vimNormCmds
  :highlight link vimGroupSpecial Special
  :highlight clear vimGroupList
  :highlight link vimSynError Error
  :highlight link vimSynContains vimSynOption
  :highlight link vimSynKeyContainedin vimSynContains
  :highlight link vimSynNextgroup vimSynOption
  :highlight link vimSynType vimSpecial
  :highlight clear vimAuSyntax
  :highlight link vimSynCase Type
  :highlight link vimSynCaseError vimError
  :highlight clear vimClusterName
  :highlight link vimGroupName vimGroup
  :highlight link vimGroupAdd vimSynOption
  :highlight link vimGroupRem vimSynOption
  :highlight clear vimIskList
  :highlight link vimIskSep Delimiter
  :highlight link vimSynKeyOpt vimSynOption
  :highlight clear vimSynKeyRegion
  :highlight link vimMtchComment vimComment
  :highlight link vimSynMtchOpt vimSynOption
  :highlight link vimSynRegPat vimString
  :highlight clear vimSynMatchRegion
  :highlight clear vimSynMtchCchar
  :highlight clear vimSynMtchGroup
  :highlight link vimSynPatRange vimString
  :highlight link vimSynNotPatRange vimSynRegPat
  :highlight link vimSynRegOpt vimSynOption
  :highlight link vimSynReg Type
  :highlight link vimSynMtchGrp vimSynOption
  :highlight clear vimSynRegion
  :highlight clear vimSynPatMod
  :highlight link vimSyncC Type
  :highlight clear vimSyncLines
  :highlight clear vimSyncMatch
  :highlight link vimSyncError Error
  :highlight clear vimSyncLinebreak
  :highlight clear vimSyncLinecont
  :highlight clear vimSyncRegion
  :highlight link vimSyncGroupName vimGroupName
  :highlight link vimSyncKey Type
  :highlight link vimSyncGroup vimGroupName
  :highlight link vimSyncNone Type
  :highlight clear vimHiLink
  :highlight link vimHiClear vimHighlight
  :highlight clear vimHiKeyList
  :highlight link vimHiCtermError vimError
  :highlight clear vimHiBang
  :highlight link vimHiGroup vimGroupName
  :highlight link vimHiAttrib PreProc
  :highlight link vimFgBgAttrib vimHiAttrib
  :highlight link vimHiAttribList vimError
  :highlight clear vimHiCtermColor
  :highlight clear vimHiFontname
  :highlight clear vimHiGuiFontname
  :highlight link vimHiGuiRgb vimNumber
  :highlight link vimHiTerm Type
  :highlight link vimHiCTerm vimHiTerm
  :highlight link vimHiStartStop vimHiTerm
  :highlight link vimHiCtermFgBg vimHiTerm
  :highlight link vimHiGui vimHiTerm
  :highlight link vimHiGuiFont vimHiTerm
  :highlight link vimHiGuiFgBg vimHiTerm
  :highlight link vimHiKeyError vimError
  :highlight clear vimHiTermcap
  :highlight link vimHiNmbr Number
  :highlight link vimCommentTitle PreProc
  :highlight clear vimCommentTitleLeader
  :highlight link vimSearchDelim Statement
  :highlight link vimSearch vimString
  :highlight link vimEmbedError vimError
  :highlight link rubyConditional Conditional
  :highlight link rubyExceptional rubyConditional
  :highlight link rubyMethodExceptional rubyDefine
  :highlight link rubyTodo Todo
  :highlight link rubyStringEscape Special
  :highlight link rubyQuoteEscape rubyStringEscape
  :highlight link rubyInterpolationDelimiter Delimiter
  :highlight clear rubyInterpolation
  :highlight link rubyInstanceVariable rubyIdentifier
  :highlight link rubyClassVariable rubyIdentifier
  :highlight link rubyGlobalVariable rubyIdentifier
  :highlight link rubyPredefinedVariable rubyPredefinedIdentifier
  :highlight link rubyInvalidVariable Error
  :highlight link rubyNoInterpolation rubyString
  :highlight clear NONE
  :highlight clear rubyDelimiterEscape
  :highlight link rubyString String
  :highlight clear rubyNestedParentheses
  :highlight clear rubyNestedCurlyBraces
  :highlight clear rubyNestedAngleBrackets
  :highlight clear rubyNestedSquareBrackets
  :highlight link rubyRegexpSpecial Special
  :highlight link rubyRegexpComment Comment
  :highlight clear rubyRegexpParens
  :highlight link rubyRegexpCharClass rubyRegexpSpecial
  :highlight link rubyRegexpEscape rubyRegexpSpecial
  :highlight clear rubyRegexpBrackets
  :highlight link rubyRegexpQuantifier rubyRegexpSpecial
  :highlight link rubyRegexpAnchor rubyRegexpSpecial
  :highlight link rubyRegexpDot rubyRegexpCharClass
  :highlight link rubyASCIICode Character
  :highlight link rubyInteger Number
  :highlight link rubyFloat Float
  :highlight clear rubyLocalVariableOrMethod
  :highlight clear rubyBlockArgument
  :highlight link rubyConstant Type
  :highlight link rubySymbol Constant
  :highlight link rubyCapitalizedMethod rubyLocalVariableOrMethod
  :highlight link rubyBlockParameter rubyIdentifier
  :highlight clear rubyBlockParameterList
  :highlight link rubyPredefinedConstant rubyPredefinedIdentifier
  :highlight link rubyRegexpDelimiter rubyStringDelimiter
  :highlight link rubyRegexp rubyString
  :highlight link rubyStringDelimiter Delimiter
  :highlight link rubySymbolDelimiter rubySymbol
  :highlight clear rubyHeredocStart
  :highlight link rubyHeredoc rubyString
  :highlight clear rubyAliasDeclaration2
  :highlight clear rubyAliasDeclaration
  :highlight link rubyBoolean Boolean
  :highlight link rubyPseudoVariable Constant
  :highlight clear rubyMethodDeclaration
  :highlight link rubyOperator Operator
  :highlight clear rubyClassDeclaration
  :highlight clear rubyModuleDeclaration
  :highlight link rubyFunction Function
  :highlight link rubyControl Statement
  :highlight link rubyKeyword Keyword
  :highlight link rubyBeginEnd Statement
  :highlight link rubyDefine Define
  :highlight link rubyClass rubyDefine
  :highlight link rubyModule rubyDefine
  :highlight clear rubyMethodBlock
  :highlight clear rubyBlock
  :highlight link rubyConditionalModifier rubyConditional
  :highlight link rubyRepeatModifier rubyRepeat
  :highlight clear rubyLineContinuation
  :highlight clear rubyDoBlock
  :highlight clear rubyCurlyBlockDelimiter
  :highlight clear rubyCurlyBlock
  :highlight clear rubyArrayDelimiter
  :highlight clear rubyArrayLiteral
  :highlight clear rubyBlockExpression
  :highlight clear rubyCaseExpression
  :highlight clear rubyConditionalExpression
  :highlight link rubyRepeat Repeat
  :highlight link rubyOptionalDo rubyRepeat
  :highlight clear rubyOptionalDoLine
  :highlight clear rubyRepeatExpression
  :highlight link rubyAccess Statement
  :highlight link rubyAttribute Statement
  :highlight link rubyEval Statement
  :highlight link rubyException Exception
  :highlight link rubyInclude Include
  :highlight link rubySharpBang PreProc
  :highlight link rubySpaceError rubyError
  :highlight link rubyComment Comment
  :highlight clear rubyMultilineComment
  :highlight link rubyDocumentation Comment
  :highlight clear rubyKeywordAsMethod
  :highlight link rubyDataDirective Delimiter
  :highlight link rubyData Comment
  :highlight link rubyIdentifier Identifier
  :highlight link rubyPredefinedIdentifier rubyIdentifier
  :highlight link rubyError Error
  :highlight link vimScriptDelim Comment
  :highlight clear vimRubyRegion
  :highlight link pythonStatement Statement
  :highlight link pythonFunction Function
  :highlight link pythonConditional Conditional
  :highlight link pythonRepeat Repeat
  :highlight link pythonOperator Operator
  :highlight link pythonException Exception
  :highlight link pythonInclude Include
  :highlight link pythonAsync Statement
  :highlight link pythonDecorator Define
  :highlight link pythonDecoratorName Function
  :highlight link pythonDoctestValue Define
  :highlight clear pythonMatrixMultiply
  :highlight link pythonTodo Todo
  :highlight link pythonComment Comment
  :highlight link pythonQuotes String
  :highlight link pythonEscape Special
  :highlight link pythonString String
  :highlight link pythonTripleQuotes pythonQuotes
  :highlight clear pythonSpaceError
  :highlight link pythonDoctest Special
  :highlight link pythonRawString String
  :highlight link pythonNumber Number
  :highlight link pythonBuiltin Function
  :highlight clear pythonAttribute
  :highlight link pythonExceptions Structure
  :highlight clear pythonSync
  :highlight clear vimPythonRegion
  :highlight clear vimAugroupSyncA
  :highlight link vimError Error
  :highlight link vimKeyCodeError vimError
  :highlight link vimWarn WarningMsg
  :highlight link vimAuHighlight vimHighlight
  :highlight link vimAutoCmdOpt vimOption
  :highlight link vimAutoSet vimCommand
  :highlight link vimCondHL vimCommand
  :highlight link vimElseif vimCondHL
  :highlight link vimFold Folded
  :highlight link vimSynOption Special
  :highlight link vimHLMod PreProc
  :highlight link vimKeyCode vimSpecFile
  :highlight link vimKeyword Statement
  :highlight link vimSpecial Type
  :highlight link vimStatement Statement
endfunction

