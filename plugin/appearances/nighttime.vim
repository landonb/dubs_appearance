" File: dubs_appearance.vim
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Last Modified: 2017.12.05
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
"   :.,$s/^\([^ ]\+\) \+xxx \(.*\)$/highlight \1 \2/gc
"
"   MAYBE/2017-12-01: I couldn't get [^\s] to work: it finds not "s" or "S"!
"
" 4. Fix all the "links to" lines:
"
"   :.,$s/^\s*highlight \([a-zA-Z0-9]\+\) links to \([a-zA-Z0-9]\+\)$/highlight link \1 \2/gc
"
" 5. Fix all the "cleared" lines:
"
"   :.,$s/^\s*highlight \([a-zA-Z0-9]\+\) cleared$/highlight clear \1/gc
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

function g:Theme_Highlight_Nighttime()
  highlight SpecialKey ctermfg=8 guifg=DarkGrey
  highlight EndOfBuffer ctermfg=0 guifg=#3B4252
  highlight NonText term=bold ctermfg=8 gui=bold guifg=#7f7f7f
  highlight Directory term=bold ctermfg=6 guifg=#88C0D0
  highlight ErrorMsg term=standout ctermbg=1 guifg=#D8DEE9 guibg=#BF616A
  highlight IncSearch term=reverse cterm=underline ctermfg=0 ctermbg=6 gui=underline guifg=#3B4252 guibg=#88C0D0
  highlight Search term=reverse ctermfg=0 ctermbg=6 guifg=#3B4252 guibg=#88C0D0
  highlight MoreMsg term=bold ctermfg=2 gui=bold guifg=#D8DEE9
  highlight ModeMsg term=bold cterm=bold gui=bold guifg=#D8DEE9
  highlight LineNr ctermfg=8 guifg=DarkGrey
  highlight CursorLineNr term=bold gui=bold guifg=#4C566A guibg=#2E3440
  highlight Question term=standout gui=bold guifg=#D8DEE9
  highlight StatusLine term=bold,reverse ctermfg=6 ctermbg=8 guifg=Yellow guibg=DarkGreen
  highlight StatusLineNC term=reverse ctermfg=7 ctermbg=1 guifg=LightGray guibg=DarkBlue
  highlight VertSplit term=reverse ctermfg=0 ctermbg=0 guifg=#060606 guibg=#060606
  highlight Title term=bold guifg=#D8DEE9
  highlight Visual term=reverse cterm=reverse ctermbg=0 guibg=#434C5E
  highlight VisualNOS term=bold,underline cterm=bold,underline ctermbg=0 gui=bold,underline guibg=#434C5E
  highlight WarningMsg term=standout ctermfg=0 ctermbg=3 guifg=#2E3440 guibg=#EBCB8B
  highlight WildMenu term=standout ctermfg=6 ctermbg=8 guifg=#88C0D0 guibg=#4C566A
  highlight Folded term=standout cterm=bold ctermfg=8 ctermbg=0 gui=bold guifg=#4C566A guibg=#3B4252
  highlight FoldColumn term=standout ctermfg=8 guifg=#4C566A guibg=#2E3440
  highlight DiffAdd term=bold ctermfg=2 ctermbg=9 guifg=#A3BE8C guibg=LightBlue
  highlight DiffChange term=bold ctermfg=3 ctermbg=13 guifg=#EBCB8B guibg=LightMagenta
  highlight DiffDelete term=bold ctermfg=1 ctermbg=11 gui=bold guifg=#BF616A guibg=LightCyan
  highlight DiffText term=reverse cterm=bold ctermbg=12 gui=bold guifg=#D8DEE9 guibg=Red
  highlight SignColumn term=standout ctermfg=0 guifg=#3B4252 guibg=#2E3440
  highlight Conceal ctermfg=7 ctermbg=8 guifg=LightGrey guibg=DarkGrey
  highlight SpellBad term=reverse cterm=undercurl gui=undercurl guibg=#2E3440 guisp=#BF616A
  highlight SpellCap term=reverse cterm=undercurl gui=undercurl guibg=#2E3440 guisp=#EBCB8B
  highlight SpellRare term=reverse cterm=undercurl gui=undercurl guibg=#2E3440 guisp=#ECEFF4
  highlight SpellLocal term=underline cterm=undercurl gui=undercurl guibg=#2E3440 guisp=#E5E9F0
  highlight Pmenu ctermbg=0 guifg=#D8DEE9 guibg=#434C5E
  highlight PmenuSel ctermfg=6 ctermbg=8 guifg=#88C0D0 guibg=#4C566A
  highlight PmenuSbar ctermbg=0 guifg=#D8DEE9 guibg=#434C5E
  highlight PmenuThumb ctermbg=8 guifg=#88C0D0 guibg=#4C566A
  highlight TabLine term=underline ctermbg=0 guifg=#D8DEE9 guibg=#3B4252
  highlight TabLineSel term=bold ctermfg=6 ctermbg=8 guifg=#88C0D0 guibg=#4C566A
  highlight TabLineFill term=reverse ctermbg=0 guifg=#D8DEE9 guibg=#3B4252
  highlight CursorColumn term=reverse ctermbg=0 guibg=#3B4252
  highlight CursorLine term=underline ctermbg=0 guibg=#3B4252
  highlight ColorColumn term=reverse ctermfg=14 ctermbg=2 guifg=#D8DEE9 guibg=#2E3440
  highlight link QuickFixLine Search
  highlight StatusLineTerm term=bold,reverse cterm=bold ctermfg=15 ctermbg=2 gui=bold guifg=bg guibg=DarkGreen
  highlight StatusLineTermNC term=reverse ctermfg=15 ctermbg=2 guifg=bg guibg=DarkGreen
  highlight Cursor guifg=#2E3440 guibg=#D8DEE9
  highlight lCursor guifg=bg guibg=fg
  highlight MatchParen term=reverse ctermfg=0 ctermbg=6 guifg=#2E3440 guibg=#88C0D0
  highlight Normal ctermfg=15 guifg=White guibg=#060606
  highlight ToolbarLine term=underline ctermbg=7 guibg=LightGrey
  highlight ToolbarButton cterm=bold ctermfg=15 ctermbg=8 gui=bold guifg=White guibg=Grey40
  highlight Comment term=bold ctermfg=8 guifg=#889cFF
  highlight Constant term=underline guifg=#D8DEE9
  highlight Special term=bold guifg=#D8DEE9
  highlight Identifier term=underline guifg=#D8DEE9
  highlight Statement term=bold ctermfg=4 gui=bold guifg=#81A1C1
  highlight PreProc term=underline ctermfg=4 guifg=#81A1C1
  highlight Type term=underline ctermfg=4 guifg=#81A1C1
  highlight Underlined term=underline cterm=underline ctermfg=5 gui=underline guifg=SlateBlue
  highlight Ignore ctermfg=15 guifg=bg
  highlight Error term=reverse ctermfg=15 ctermbg=12 guifg=White guibg=Red
  highlight Todo term=standout ctermfg=3 guifg=#EBCB8B guibg=Yellow
  highlight String ctermfg=2 guifg=#A3BE8C
  highlight Character ctermfg=2 guifg=#A3BE8C
  highlight Number ctermfg=5 guifg=#B48EAD
  highlight Boolean ctermfg=4 guifg=#81A1C1
  highlight Float ctermfg=5 guifg=#B48EAD
  highlight Function ctermfg=6 guifg=#88C0D0
  highlight Conditional ctermfg=4 guifg=#81A1C1
  highlight Repeat ctermfg=4 guifg=#81A1C1
  highlight Label ctermfg=4 guifg=#81A1C1
  highlight Operator ctermfg=4 guifg=#81A1C1
  highlight Keyword ctermfg=4 guifg=#81A1C1
  highlight Exception ctermfg=4 guifg=#81A1C1
  highlight Include ctermfg=4 guifg=#81A1C1
  highlight Define ctermfg=4 guifg=#81A1C1
  highlight link Macro Define
  highlight link PreCondit PreProc
  highlight StorageClass ctermfg=4 guifg=#81A1C1
  highlight Structure ctermfg=4 guifg=#81A1C1
  highlight Typedef ctermfg=4 guifg=#81A1C1
  highlight Tag guifg=#D8DEE9
  highlight SpecialChar ctermfg=3 guifg=#EBCB8B
  highlight Delimiter ctermfg=15 guifg=#ECEFF4
  highlight SpecialComment ctermfg=6 guifg=#88C0D0
  highlight link Debug Special
  highlight MyErrorMsg term=standout ctermfg=15 ctermbg=4 guibg=LightBlue
  highlight link SyntasticError SpellBad
  highlight link SyntasticWarning SpellCap
  highlight link SyntasticStyleError SyntasticError
  highlight link SyntasticStyleWarning SyntasticWarning
  highlight link GPGWarning WarningMsg
  highlight link GPGError ErrorMsg
  highlight link GPGHighlightUnknownRecipient ErrorMsg
  highlight link vimTodo Todo
  highlight link vimCommand Statement
  highlight clear vimStdPlugin
  highlight link vimOption PreProc
  highlight link vimErrSetting vimError
  highlight link vimAutoEvent Type
  highlight link vimGroup Type
  highlight link vimHLGroup vimGroup
  highlight link vimFuncName Function
  highlight clear vimGlobal
  highlight link vimSubst vimCommand
  highlight link vimNumber Number
  highlight link vimAddress vimMark
  highlight link vimAutoCmd vimCommand
  highlight clear vimIsCommand
  highlight clear vimExtCmd
  highlight clear vimFilter
  highlight link vimLet vimCommand
  highlight link vimMap vimCommand
  highlight link vimMark Number
  highlight clear vimSet
  highlight link vimSyntax vimCommand
  highlight clear vimUserCmd
  highlight clear vimCmdSep
  highlight link vimVar Identifier
  highlight link vimFBVar vimVar
  highlight link vimInsert vimString
  highlight link vimBehaveModel vimBehave
  highlight link vimBehaveError vimError
  highlight link vimBehave vimCommand
  highlight link vimFTCmd vimCommand
  highlight link vimFTOption vimSynType
  highlight link vimFTError vimError
  highlight clear vimFiletype
  highlight vimAugroup ctermfg=14 guifg=#8FBCBB
  highlight clear vimExecute
  highlight link vimNotFunc vimCommand
  highlight link vimFunction Function
  highlight link vimFunctionError vimError
  highlight link vimLineComment vimComment
  highlight link vimSpecFile Identifier
  highlight link vimOper Operator
  highlight clear vimOperParen
  highlight link vimComment Comment
  highlight link vimString String
  highlight link vimRegister SpecialChar
  highlight link vimCmplxRepeat SpecialChar
  highlight clear vimRegion
  highlight clear vimSynLine
  highlight vimNotation ctermfg=14 guifg=#8FBCBB
  highlight link vimCtrlChar SpecialChar
  highlight link vimFuncVar Identifier
  highlight link vimContinue Special
  highlight link vimAugroupKey vimCommand
  highlight link vimAugroupError vimError
  highlight link vimEnvvar PreProc
  highlight link vimFunc Function
  highlight link vimParenSep Delimiter
  highlight link vimSep Delimiter
  highlight link vimOperError Error
  highlight link vimFuncKey vimCommand
  highlight link vimFuncSID Special
  highlight link vimAbb vimCommand
  highlight clear vimEcho
  highlight link vimEchoHL vimCommand
  highlight clear vimIf
  highlight link vimHighlight vimCommand
  highlight link vimNorm vimCommand
  highlight link vimUnmap vimMap
  highlight link vimUserCommand vimCommand
  highlight clear vimFuncBody
  highlight clear vimFuncBlank
  highlight link vimPattern Type
  highlight link vimSpecFileMod vimSpecFile
  highlight clear vimEscapeBrace
  highlight clear vimSetEqual
  highlight link vimSetString vimString
  highlight clear vimSubstRep
  highlight clear vimSubstRange
  highlight link vimUserAttrb vimSpecial
  highlight link vimUserAttrbError Error
  highlight link vimUserAttrbKey vimOption
  highlight link vimUserAttrbCmplt vimSpecial
  highlight link vimUserCmdError Error
  highlight link vimUserAttrbCmpltFunc Special
  highlight link vimCommentString vimString
  highlight link vimPatSepErr vimPatSep
  highlight link vimPatSep SpecialChar
  highlight link vimPatSepZ vimPatSep
  highlight link vimPatSepZone vimString
  highlight link vimPatSepR vimPatSep
  highlight clear vimPatRegion
  highlight link vimNotPatSep vimString
  highlight link vimStringCont vimString
  highlight link vimSubstTwoBS vimString
  highlight link vimSubstSubstr SpecialChar
  highlight clear vimCollection
  highlight clear vimSubstPat
  highlight link vimSubst1 vimSubst
  highlight link vimSubstDelim Delimiter
  highlight clear vimSubstRep4
  highlight link vimSubstFlagErr vimError
  highlight clear vimCollClass
  highlight link vimCollClassErr vimError
  highlight link vimSubstFlags Special
  highlight link vimMarkNumber vimNumber
  highlight link vimPlainMark vimMark
  highlight link vimPlainRegister vimRegister
  highlight link vimSetMod vimOption
  highlight link vimSetSep Statement
  highlight link vimMapMod vimBracket
  highlight clear vimMapLhs
  highlight clear vimAutoCmdSpace
  highlight clear vimAutoEventList
  highlight clear vimAutoCmdSfxList
  highlight link vimEchoHLNone vimGroup
  highlight link vimMapBang vimCommand
  highlight vimMapRhs ctermfg=14 guifg=#8FBCBB
  highlight link vimMapModKey vimFuncSID
  highlight link vimMapModErr vimError
  highlight clear vimMapRhsExtend
  highlight clear vimMenuBang
  highlight clear vimMenuPriority
  highlight link vimMenuName PreProc
  highlight link vimMenuMod vimMapMod
  highlight link vimMenuNameMore vimMenuName
  highlight clear vimMenuMap
  highlight clear vimMenuRhs
  highlight link vimBracket Delimiter
  highlight link vimUserFunc Function
  highlight link vimElseIfErr Error
  highlight link vimBufnrWarn vimWarn
  highlight clear vimNormCmds
  highlight link vimGroupSpecial Special
  highlight clear vimGroupList
  highlight link vimSynError Error
  highlight link vimSynContains vimSynOption
  highlight link vimSynKeyContainedin vimSynContains
  highlight link vimSynNextgroup vimSynOption
  highlight link vimSynType vimSpecial
  highlight clear vimAuSyntax
  highlight link vimSynCase Type
  highlight link vimSynCaseError vimError
  highlight clear vimClusterName
  highlight link vimGroupName vimGroup
  highlight link vimGroupAdd vimSynOption
  highlight link vimGroupRem vimSynOption
  highlight clear vimIskList
  highlight link vimIskSep Delimiter
  highlight link vimSynKeyOpt vimSynOption
  highlight clear vimSynKeyRegion
  highlight link vimMtchComment vimComment
  highlight link vimSynMtchOpt vimSynOption
  highlight link vimSynRegPat vimString
  highlight clear vimSynMatchRegion
  highlight clear vimSynMtchCchar
  highlight clear vimSynMtchGroup
  highlight link vimSynPatRange vimString
  highlight link vimSynNotPatRange vimSynRegPat
  highlight link vimSynRegOpt vimSynOption
  highlight link vimSynReg Type
  highlight link vimSynMtchGrp vimSynOption
  highlight clear vimSynRegion
  highlight clear vimSynPatMod
  highlight link vimSyncC Type
  highlight clear vimSyncLines
  highlight clear vimSyncMatch
  highlight link vimSyncError Error
  highlight clear vimSyncLinebreak
  highlight clear vimSyncLinecont
  highlight clear vimSyncRegion
  highlight link vimSyncGroupName vimGroupName
  highlight link vimSyncKey Type
  highlight link vimSyncGroup vimGroupName
  highlight link vimSyncNone Type
  highlight clear vimHiLink
  highlight link vimHiClear vimHighlight
  highlight clear vimHiKeyList
  highlight link vimHiCtermError vimError
  highlight clear vimHiBang
  highlight link vimHiGroup vimGroupName
  highlight link vimHiAttrib PreProc
  highlight link vimFgBgAttrib vimHiAttrib
  highlight link vimHiAttribList vimError
  highlight clear vimHiCtermColor
  highlight clear vimHiFontname
  highlight clear vimHiGuiFontname
  highlight link vimHiGuiRgb vimNumber
  highlight link vimHiTerm Type
  highlight link vimHiCTerm vimHiTerm
  highlight link vimHiStartStop vimHiTerm
  highlight link vimHiCtermFgBg vimHiTerm
  highlight link vimHiGui vimHiTerm
  highlight link vimHiGuiFont vimHiTerm
  highlight link vimHiGuiFgBg vimHiTerm
  highlight link vimHiKeyError vimError
  highlight clear vimHiTermcap
  highlight link vimHiNmbr Number
  highlight link vimCommentTitle PreProc
  highlight clear vimCommentTitleLeader
  highlight link vimSearchDelim Statement
  highlight link vimSearch vimString
  highlight link vimEmbedError vimError
  highlight link rubyConditional Conditional
  highlight link rubyExceptional rubyConditional
  highlight link rubyMethodExceptional rubyDefine
  highlight link rubyTodo Todo
  highlight link rubyStringEscape Special
  highlight link rubyQuoteEscape rubyStringEscape
  highlight link rubyInterpolationDelimiter Keyword
  highlight clear rubyInterpolation
  highlight link rubyInstanceVariable rubyIdentifier
  highlight link rubyClassVariable rubyIdentifier
  highlight link rubyGlobalVariable rubyIdentifier
  highlight link rubyPredefinedVariable rubyPredefinedIdentifier
  highlight link rubyInvalidVariable Error
  highlight link rubyNoInterpolation rubyString
  highlight clear NONE
  highlight clear rubyDelimiterEscape
  highlight link rubyString String
  highlight clear rubyNestedParentheses
  highlight clear rubyNestedCurlyBraces
  highlight clear rubyNestedAngleBrackets
  highlight clear rubyNestedSquareBrackets
  highlight link rubyRegexpSpecial Special
  highlight link rubyRegexpComment Comment
  highlight clear rubyRegexpParens
  highlight link rubyRegexpCharClass rubyRegexpSpecial
  highlight link rubyRegexpEscape rubyRegexpSpecial
  highlight clear rubyRegexpBrackets
  highlight link rubyRegexpQuantifier rubyRegexpSpecial
  highlight link rubyRegexpAnchor rubyRegexpSpecial
  highlight link rubyRegexpDot rubyRegexpCharClass
  highlight link rubyASCIICode Character
  highlight link rubyInteger Number
  highlight link rubyFloat Float
  highlight link rubyLocalVariableOrMethod Function
  highlight clear rubyBlockArgument
  highlight rubyConstant ctermfg=14 guifg=#8FBCBB
  highlight rubySymbol cterm=bold ctermfg=15 gui=bold guifg=#ECEFF4
  highlight link rubyCapitalizedMethod rubyLocalVariableOrMethod
  highlight link rubyBlockParameter rubyIdentifier
  highlight link rubyBlockParameterList Operator
  highlight link rubyPredefinedConstant rubyPredefinedIdentifier
  highlight link rubyRegexpDelimiter rubyStringDelimiter
  highlight link rubyRegexp SpecialChar
  highlight link rubyStringDelimiter Delimiter
  highlight link rubySymbolDelimiter rubySymbol
  highlight clear rubyHeredocStart
  highlight link rubyHeredoc rubyString
  highlight clear rubyAliasDeclaration2
  highlight clear rubyAliasDeclaration
  highlight link rubyBoolean Boolean
  highlight link rubyPseudoVariable Keyword
  highlight clear rubyMethodDeclaration
  highlight link rubyOperator Operator
  highlight clear rubyClassDeclaration
  highlight clear rubyModuleDeclaration
  highlight link rubyFunction Function
  highlight link rubyControl Statement
  highlight link rubyKeyword Keyword
  highlight link rubyBeginEnd Statement
  highlight link rubyDefine Define
  highlight link rubyClass rubyDefine
  highlight link rubyModule rubyDefine
  highlight clear rubyMethodBlock
  highlight clear rubyBlock
  highlight link rubyConditionalModifier rubyConditional
  highlight link rubyRepeatModifier rubyRepeat
  highlight clear rubyLineContinuation
  highlight clear rubyDoBlock
  highlight clear rubyCurlyBlockDelimiter
  highlight clear rubyCurlyBlock
  highlight clear rubyArrayDelimiter
  highlight clear rubyArrayLiteral
  highlight clear rubyBlockExpression
  highlight clear rubyCaseExpression
  highlight clear rubyConditionalExpression
  highlight link rubyRepeat Repeat
  highlight link rubyOptionalDo rubyRepeat
  highlight clear rubyOptionalDoLine
  highlight clear rubyRepeatExpression
  highlight link rubyAccess Statement
  highlight link rubyAttribute Identifier
  highlight link rubyEval Statement
  highlight link rubyException Exception
  highlight link rubyInclude Include
  highlight link rubySharpBang PreProc
  highlight link rubySpaceError rubyError
  highlight link rubyComment Comment
  highlight clear rubyMultilineComment
  highlight link rubyDocumentation Comment
  highlight link rubyKeywordAsMethod Function
  highlight link rubyDataDirective Delimiter
  highlight link rubyData Comment
  highlight link rubyIdentifier Identifier
  highlight link rubyPredefinedIdentifier rubyIdentifier
  highlight link rubyError Error
  highlight link vimScriptDelim Comment
  highlight clear vimRubyRegion
  highlight link pythonStatement Statement
  highlight link pythonFunction Function
  highlight link pythonConditional Conditional
  highlight link pythonRepeat Repeat
  highlight link pythonOperator Operator
  highlight link pythonException Exception
  highlight link pythonInclude Include
  highlight link pythonAsync Statement
  highlight link pythonDecorator Define
  highlight link pythonDecoratorName Function
  highlight link pythonDoctestValue Define
  highlight clear pythonMatrixMultiply
  highlight link pythonTodo Todo
  highlight link pythonComment Comment
  highlight link pythonQuotes String
  highlight link pythonEscape SpecialChar
  highlight link pythonString String
  highlight link pythonTripleQuotes pythonQuotes
  highlight clear pythonSpaceError
  highlight link pythonDoctest Special
  highlight link pythonRawString String
  highlight link pythonNumber Number
  highlight link pythonBuiltin Type
  highlight clear pythonAttribute
  highlight link pythonExceptions Structure
  highlight clear pythonSync
  highlight clear vimPythonRegion
  highlight clear vimAugroupSyncA
  highlight link vimError Error
  highlight link vimKeyCodeError vimError
  highlight link vimWarn WarningMsg
  highlight link vimAuHighlight vimHighlight
  highlight link vimAutoCmdOpt vimOption
  highlight link vimAutoSet vimCommand
  highlight link vimCondHL vimCommand
  highlight link vimElseif vimCondHL
  highlight link vimFold Folded
  highlight link vimSynOption Special
  highlight link vimHLMod PreProc
  highlight link vimKeyCode vimSpecFile
  highlight link vimKeyword Statement
  highlight link vimSpecial Type
  highlight link vimStatement Statement
  highlight link SyntasticErrorSign Error
  highlight link SyntasticWarningSign Todo
  highlight link SyntasticStyleErrorSign SyntasticErrorSign
  highlight link SyntasticStyleWarningSign SyntasticWarningSign
  highlight link SyntasticStyleErrorLine SyntasticErrorLine
  highlight clear SyntasticErrorLine
  highlight link SyntasticStyleWarningLine SyntasticWarningLine
  highlight clear SyntasticWarningLine
  highlight Bold cterm=bold gui=bold
  highlight clear Italic
  highlight Underline cterm=underline gui=underline
  highlight iCursor guifg=#2E3440 guibg=#D8DEE9
  highlight healthError ctermfg=1 ctermbg=0 guifg=#BF616A guibg=#3B4252
  highlight healthSuccess ctermfg=2 ctermbg=0 guifg=#A3BE8C guibg=#3B4252
  highlight healthWarning ctermfg=3 ctermbg=0 guifg=#EBCB8B guibg=#3B4252
  highlight awkCharClass ctermfg=14 guifg=#8FBCBB
  highlight awkPatterns cterm=bold ctermfg=4 gui=bold guifg=#81A1C1
  highlight link awkArrayElement Identifier
  highlight link awkBoolLogic Keyword
  highlight link awkBrktRegExp SpecialChar
  highlight link awkComma Delimiter
  highlight link awkExpression Keyword
  highlight link awkFieldVars Identifier
  highlight link awkLineSkip Keyword
  highlight link awkOperator Operator
  highlight link awkRegExp SpecialChar
  highlight link awkSearch Keyword
  highlight link awkSemicolon Delimiter
  highlight link awkSpecialCharacter SpecialChar
  highlight link awkSpecialPrintf SpecialChar
  highlight link awkVariables Identifier
  highlight cIncluded ctermfg=14 guifg=#8FBCBB
  highlight link cOperator Operator
  highlight link cPreCondit PreCondit
  highlight link csPreCondit PreCondit
  highlight link csType Type
  highlight link csXmlTag SpecialComment
  highlight cssAttributeSelector ctermfg=14 guifg=#8FBCBB
  highlight cssDefinition ctermfg=14 guifg=#8FBCBB
  highlight cssIdentifier cterm=underline ctermfg=14 gui=underline guifg=#8FBCBB
  highlight cssStringQ ctermfg=14 guifg=#8FBCBB
  highlight link cssAttr Keyword
  highlight link cssBraces Delimiter
  highlight link cssClassName cssDefinition
  highlight link cssColor Number
  highlight link cssProp cssDefinition
  highlight link cssPseudoClass cssDefinition
  highlight link cssPseudoClassId cssPseudoClass
  highlight link cssVendor Keyword
  highlight dosiniHeader ctermfg=6 guifg=#88C0D0
  highlight link dosiniLabel Type
  highlight dtBooleanKey ctermfg=14 guifg=#8FBCBB
  highlight dtExecKey ctermfg=14 guifg=#8FBCBB
  highlight dtLocaleKey ctermfg=14 guifg=#8FBCBB
  highlight dtNumericKey ctermfg=14 guifg=#8FBCBB
  highlight dtTypeKey ctermfg=14 guifg=#8FBCBB
  highlight link dtDelim Delimiter
  highlight link dtLocaleValue Keyword
  highlight link dtTypeValue Keyword
  highlight diffAdded ctermfg=2 guifg=#A3BE8C
  highlight diffChanged ctermfg=3 guifg=#EBCB8B
  highlight diffNewFile ctermfg=6 guifg=#88C0D0
  highlight diffOldFile ctermfg=14 guifg=#8FBCBB
  highlight diffRemoved ctermfg=1 guifg=#BF616A
  highlight gitconfigVariable ctermfg=14 guifg=#8FBCBB
  highlight goBuiltins ctermfg=14 guifg=#8FBCBB
  highlight link goConstants Keyword
  highlight htmlArg ctermfg=14 guifg=#8FBCBB
  highlight htmlLink guifg=#D8DEE9
  highlight link htmlBold Bold
  highlight link htmlEndTag htmlTag
  highlight link htmlTag Keyword
  highlight link htmlItalic Italic
  highlight link htmlSpecialChar SpecialChar
  highlight link htmlTagN htmlTag
  highlight javaDocTags ctermfg=14 guifg=#8FBCBB
  highlight link javaCommentTitle Comment
  highlight link javaScriptBraces Delimiter
  highlight link javaScriptIdentifier Keyword
  highlight link javaScriptNumber Number
  highlight jsonKeyword ctermfg=14 guifg=#8FBCBB
  highlight lessClass ctermfg=14 guifg=#8FBCBB
  highlight link lessAmpersand Keyword
  highlight link lessCssAttribute Delimiter
  highlight link lessFunction Function
  highlight link cssSelectorOp Keyword
  highlight link lispAtomBarSymbol SpecialChar
  highlight link lispAtomList SpecialChar
  highlight link lispAtomMark Keyword
  highlight link lispBarSymbol SpecialChar
  highlight link lispFunc Function
  highlight link luaFunc Function
  highlight markdownBlockquote ctermfg=14 guifg=#8FBCBB
  highlight markdownCode ctermfg=14 guifg=#8FBCBB
  highlight markdownCodeDelimiter ctermfg=14 guifg=#8FBCBB
  highlight markdownFootnote ctermfg=14 guifg=#8FBCBB
  highlight markdownId ctermfg=14 guifg=#8FBCBB
  highlight markdownIdDeclaration ctermfg=14 guifg=#8FBCBB
  highlight markdownH1 ctermfg=6 guifg=#88C0D0
  highlight markdownLinkText ctermfg=14 guifg=#8FBCBB
  highlight markdownUrl guifg=#D8DEE9
  highlight link markdownFootnoteDefinition markdownFootnote
  highlight link markdownH2 markdownH1
  highlight link markdownH3 markdownH1
  highlight link markdownH4 markdownH1
  highlight link markdownH5 markdownH1
  highlight link markdownH6 markdownH1
  highlight link markdownIdDelimiter Keyword
  highlight link markdownLinkDelimiter Keyword
  highlight link markdownLinkTextDelimiter Keyword
  highlight link markdownListMarker Keyword
  highlight link markdownRule Keyword
  highlight link markdownHeadingDelimiter Keyword
  highlight perlPackageDecl ctermfg=14 guifg=#8FBCBB
  highlight phpClasses ctermfg=14 guifg=#8FBCBB
  highlight phpDocTags ctermfg=14 guifg=#8FBCBB
  highlight link phpDocCustomTags phpDocTags
  highlight link phpMemberSelector Keyword
  highlight podCmdText ctermfg=14 guifg=#8FBCBB
  highlight podVerbatimLine guifg=#D8DEE9
  highlight link podFormat Keyword
  highlight sassClass ctermfg=14 guifg=#8FBCBB
  highlight sassId cterm=underline ctermfg=14 gui=underline guifg=#8FBCBB
  highlight link sassAmpersand Keyword
  highlight link sassClassChar Delimiter
  highlight link sassControl Keyword
  highlight link sassControlLine Keyword
  highlight link sassExtend Keyword
  highlight link sassFor Keyword
  highlight link sassFunctionDecl Keyword
  highlight link sassFunctionName Function
  highlight link sassidChar sassId
  highlight link sassInclude SpecialChar
  highlight link sassMixinName Function
  highlight link sassMixing SpecialChar
  highlight link sassReturn Keyword
  highlight link shCmdParenRegion Delimiter
  highlight link shCmdSubRegion Delimiter
  highlight link shDerefSimple Identifier
  highlight link shDerefVar Identifier
  highlight link sqlKeyword Keyword
  highlight link sqlSpecial Keyword
  highlight xmlAttrib ctermfg=14 guifg=#8FBCBB
  highlight xmlCdataStart cterm=bold ctermfg=8 gui=bold guifg=#4C566A
  highlight xmlNamespace ctermfg=14 guifg=#8FBCBB
  highlight link xmlAttribPunct Delimiter
  highlight link xmlCdata Comment
  highlight link xmlCdataCdata xmlCdataStart
  highlight link xmlCdataEnd xmlCdataStart
  highlight link xmlEndTag xmlTagName
  highlight link xmlTagName Keyword
  highlight link xmlProcessingDelim Keyword
  highlight yamlBlockMappingKey ctermfg=14 guifg=#8FBCBB
  highlight link yamlBool Keyword
  highlight link yamlDocumentStart Keyword
  highlight ALEWarningSign ctermfg=3 guifg=#EBCB8B
  highlight ALEErrorSign ctermfg=1 guifg=#BF616A
  highlight GitGutterAdd ctermfg=2 guifg=#A3BE8C
  highlight GitGutterChange ctermfg=3 guifg=#EBCB8B
  highlight GitGutterChangeDelete ctermfg=1 guifg=#BF616A
  highlight GitGutterDelete ctermfg=1 guifg=#BF616A
  highlight jediFunction ctermbg=8 guifg=#D8DEE9 guibg=#4C566A
  highlight jediFat cterm=bold,underline ctermfg=6 ctermbg=8 gui=bold,underline guifg=#88C0D0 guibg=#4C566A
  highlight NERDTreeExecFile ctermfg=14 guifg=#8FBCBB
  highlight link NERDTreeDirSlash Keyword
  highlight link NERDTreeHelp Comment
  highlight link CtrlPMatch Keyword
  highlight link CtrlPBufferHid Normal
  highlight jsGlobalNodeObjects ctermfg=6 guifg=#88C0D0
  highlight link jsBrackets Delimiter
  highlight link jsFuncCall Function
  highlight link jsFuncParens Delimiter
  highlight link jsNoise Delimiter
  highlight link jsPrototype Keyword
  highlight link jsRegexpString SpecialChar
  highlight link projectDescription Identifier
  highlight link projectWhiteError Error
  highlight clear projectDescriptionDir
  highlight link projectDirectory Constant
  highlight link projectScriptinout Identifier
  highlight link projectComment Comment
  highlight clear projectCD
  highlight link projectFilterError Error
  highlight link projectFilter Identifier
  highlight link projectFilterRegexp String
  highlight clear projectFilterEntry
  highlight link projectExcludeError Error
  highlight link projectExclude Identifier
  highlight link projectExcludeRegexp String
  highlight clear projectExcludeEntry
  highlight link projectFlags Identifier
  highlight clear projectFlagsEntry
  highlight link projectFlagsValues String
  highlight link projectFlagsError Error
  highlight link projectFoldText Identifier
  highlight link shDoError Error
  highlight link shIfError Error
  highlight link shInError Error
  highlight link shCaseError Error
  highlight link shEsacError Error
  highlight link shCurlyError Error
  highlight link shParenError Error
  highlight link shTestError Error
  highlight clear shOK
  highlight link shArithmetic Special
  highlight clear shCaseEsac
  highlight link shComment Comment
  highlight link shDeref shShellVariables
  highlight clear shDo
  highlight link shEcho shString
  highlight link shEscape shCommandSub
  highlight link shNumber Number
  highlight link shOperator Operator
  highlight link shPosnParm shShellVariables
  highlight link shExSingleQuote shSingleQuote
  highlight link shExDoubleQuote shDoubleQuote
  highlight link shHereString shRedir
  highlight link shRedir shOperator
  highlight link shSingleQuote shString
  highlight link shDoubleQuote shString
  highlight link shStatement Statement
  highlight link shVariable shSetList
  highlight link shAlias Identifier
  highlight clear shTest
  highlight link shCtrlSeq Special
  highlight link shSpecial Special
  highlight link shParen shArithmetic
  highlight link bashSpecialVariables shShellVariables
  highlight link bashStatement shStatement
  highlight clear shIf
  highlight clear shFor
  highlight link shCaseStart shConditional
  highlight clear shCase
  highlight link shCaseBar shConditional
  highlight link shCaseIn shConditional
  highlight link shCaseCommandSub shCommandSub
  highlight clear shCaseExSingleQuote
  highlight link shCaseSingleQuote shSingleQuote
  highlight link shCaseDoubleQuote shDoubleQuote
  highlight link shStringSpecial shSpecial
  highlight clear shCaseRange
  highlight link shColon shComment
  highlight link shCommandSub Special
  highlight clear shExpr
  highlight link shHereDoc shString
  highlight link shSetList Identifier
  highlight link shSource shOperator
  highlight link shOption shCommandSub
  highlight clear shSubSh
  highlight clear shComma
  highlight link shDerefSpecial shDeref
  highlight link shDerefWordError Error
  highlight link shDerefPSR shDerefOp
  highlight link shDerefPPS shDerefOp
  highlight link shDerefOff shDerefOp
  highlight link shDerefOp shOperator
  highlight clear shDerefVarArray
  highlight link shDerefOpError Error
  highlight link shEchoQuote shString
  highlight link shCharClass shSpecial
  highlight clear shDblBrace
  highlight link shRepeat Repeat
  highlight clear shDblParen
  highlight link shBeginHere shRedir
  highlight link shHerePayload shHereDoc
  highlight link shWrapLineOperator shOperator
  highlight link shSetOption shOption
  highlight link shAtExpr shSetList
  highlight link shFunctionKey Function
  highlight clear shFunctionOne
  highlight clear shFunctionTwo
  highlight link shConditional Conditional
  highlight link shForPP shLoop
  highlight link shSet Statement
  highlight link shTestOpr shConditional
  highlight clear shTouch
  highlight link shSpecialNoZS shSpecial
  highlight link shEchoDelim shOperator
  highlight link shQuickComment shComment
  highlight clear shSpecialVar
  highlight link shEmbeddedEcho shString
  highlight link shTouchCmd shStatement
  highlight link shPattern shString
  highlight link shExprRegion Delimiter
  highlight link shSpecialNxt shSpecial
  highlight link shSubShRegion shOperator
  highlight link shRange shOperator
  highlight link shNoQuote shDoubleQuote
  highlight link shString String
  highlight link shAstQuote shDoubleQuote
  highlight link shTestDoubleQuote shString
  highlight link shTestSingleQuote shString
  highlight link shTestPattern shString
  highlight link shLoop shStatement
  highlight clear shCurlyIn
  highlight link shSnglCase Statement
  highlight link shQuote shOperator
  highlight link shArithRegion shShellVariables
  highlight clear shSkipInitWS
  highlight link bashAdminStatement shStatement
  highlight clear shBkslshSnglQuote
  highlight clear shBkslshDblQuote
  highlight link shTodo Todo
  highlight link shHereDoc01 shRedir
  highlight link shHereDoc02 shRedir
  highlight link shHereDoc03 shRedir
  highlight link shHereDoc04 shRedir
  highlight link shHereDoc05 shRedir
  highlight link shHereDoc06 shRedir
  highlight link shHereDoc07 shRedir
  highlight link shHereDoc08 shRedir
  highlight link shHereDoc09 shRedir
  highlight link shHereDoc10 shRedir
  highlight link shHereDoc11 shRedir
  highlight link shHereDoc12 shRedir
  highlight link shHereDoc13 shRedir
  highlight link shHereDoc14 shRedir
  highlight link shHereDoc15 shRedir
  highlight clear shVarAssign
  highlight link shSetListDelim shOperator
  highlight link shFunction Function
  highlight clear shFunctionStart
  highlight clear shFunctionThree
  highlight clear shFunctionFour
  highlight clear shDerefPattern
  highlight link shDerefString shDoubleQuote
  highlight clear shDerefEscape
  highlight link shDerefDelim shOperator
  highlight link shDerefLen shDerefOff
  highlight clear shDerefPPSleft
  highlight clear shDerefPPSright
  highlight clear shDerefPSRleft
  highlight clear shDerefPSRright
  highlight link shCondError Error
  highlight clear shCaseEsacSync
  highlight clear shDoSync
  highlight clear shForSync
  highlight clear shIfSync
  highlight clear shUntilSync
  highlight clear shWhileSync
  highlight link shShellVariables PreProc
  highlight link shDerefPOL shDerefOp
  highlight link shFunctionName Function
endfunction

