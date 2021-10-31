" vi:syntax=vim

" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" Default Dark scheme by Chris Kempson (http://chriskempson.com)

" GUI color definitions
let s:gui00        = "#181818"
let s:gui01        = "#282828"
let s:gui02        = "#383838"
let s:gui03        = "#585858"
let s:gui04        = "#b8b8b8"
let s:gui05        = "#d8d8d8"
let s:gui06        = "#e8e8e8"
let s:gui07        = "#f8f8f8"
let s:gui08        = "#ab4642"
let s:gui09        = "#dc9656"
let s:gui0A        = "#f7ca88"
let s:gui0B        = "#a1b56c"
let s:gui0C        = "#86c1b9"
let s:gui0D        = "#7cafc2"
let s:gui0E        = "#ba8baf"
let s:gui0F        = "#a16946"
let s:gui10        = "#999999"
let s:gui11        = "#226699"
let s:gui12        = "#330000"

" Theme setup
hi clear
syntax reset
let g:colors_name = "base16-ghetto"

" Highlighting function
" Optional variables are attributes and guisp
function! g:Base16hi(group, guifg, guibg, ...)
  let l:attr = get(a:, 1, "")
  let l:guisp = get(a:, 2, "")

  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if l:attr != ""
    exec "hi " . a:group . " gui=" . l:attr
  endif
  if l:guisp != ""
    exec "hi " . a:group . " guisp=" . l:guisp
  endif
endfunction


fun <sid>hi(group, guifg, guibg, attr, guisp)
  call g:Base16hi(a:group, a:guifg, a:guibg, a:attr, a:guisp)
endfun

" Vim editor colors
call <sid>hi("Normal",        s:gui05, "", "", "")
call <sid>hi("Bold",          "", "", "bold", "")
call <sid>hi("Debug",         s:gui08, "", "", "")
call <sid>hi("Directory",     s:gui0D, "", "", "")
call <sid>hi("Error",         s:gui00, s:gui08, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, "", "")
call <sid>hi("Exception",     s:gui08, "", "", "")
call <sid>hi("FoldColumn",    s:gui0C, "", "", "")
call <sid>hi("Folded",        s:gui04, s:gui01, "", "")
call <sid>hi("IncSearch",     s:gui01, s:gui09, "none", "")
call <sid>hi("Italic",        "", "", "none", "")
call <sid>hi("Macro",         s:gui08, "", "", "")
call <sid>hi("MatchParen",    "", s:gui03, "", "")
call <sid>hi("ModeMsg",       s:gui0B, "", "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", "", "")
call <sid>hi("Question",      s:gui0D, "", "", "")
call <sid>hi("Search",        s:gui01, s:gui0A, "", "")
call <sid>hi("Substitute",    s:gui01, s:gui0A, "none", "")
call <sid>hi("SpecialKey",    s:gui03, "", "", "")
call <sid>hi("TooLong",       s:gui08, "", "", "")
call <sid>hi("Underlined",    s:gui08, "", "underline", "")
call <sid>hi("Visual",        "", s:gui02, "", "")
call <sid>hi("VisualNOS",     s:gui08, "", "", "")
call <sid>hi("WarningMsg",    s:gui08, "", "", "")
call <sid>hi("WildMenu",      s:gui08, s:gui0A, "", "")
call <sid>hi("Title",         s:gui0D, "", "none", "")
call <sid>hi("Conceal",       s:gui0D, s:gui00, "", "")
call <sid>hi("Cursor",        s:gui00, s:gui05, "", "")
call <sid>hi("NonText",       s:gui03, "", "", "")
call <sid>hi("LineNr",        s:gui04, "", "", "")
call <sid>hi("SignColumn",    s:gui03, "", "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui00, "none", "")
call <sid>hi("StatusLineNC",  s:gui03, "", "none", "")
call <sid>hi("VertSplit",     s:gui00, s:gui00, "none", "")
call <sid>hi("ColorColumn",   "", s:gui12, "none", "")
call <sid>hi("CursorColumn",  "", s:gui00, "none", "")
call <sid>hi("CursorLine",    "", s:gui00, "none", "")
call <sid>hi("CursorLineNr",  s:gui09, "", "", "")
call <sid>hi("QuickFixLine",  "", s:gui01, "none", "")
call <sid>hi("PMenu",         s:gui05, s:gui01, "none", "")
call <sid>hi("PMenuSel",      s:gui05, s:gui11, "", "")
call <sid>hi("TabLine",       s:gui03, s:gui01, "none", "")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, "none", "")
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, "none", "")
call <sid>hi("NormalFloat",   s:gui05, s:gui02, "", "")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", "", "")
call <sid>hi("Character",    s:gui08, "", "", "")
call <sid>hi("Comment",      s:gui10, "", "italic", "")
call <sid>hi("Conditional",  s:gui0E, "", "", "")
call <sid>hi("Constant",     s:gui09, "", "", "")
call <sid>hi("Define",       s:gui0E, "", "none", "")
call <sid>hi("Delimiter",    s:gui0F, "", "", "")
call <sid>hi("Float",        s:gui09, "", "", "")
call <sid>hi("Function",     s:gui0D, "", "", "")
call <sid>hi("Identifier",   s:gui08, "", "none", "")
call <sid>hi("Include",      s:gui0D, "", "", "")
call <sid>hi("Keyword",      s:gui0E, "", "", "")
call <sid>hi("Label",        s:gui0A, "", "", "")
call <sid>hi("Number",       s:gui09, "", "", "")
call <sid>hi("Operator",     s:gui05, "", "none", "")
call <sid>hi("PreProc",      s:gui0A, "", "", "")
call <sid>hi("Repeat",       s:gui0A, "", "", "")
call <sid>hi("Special",      s:gui0C, "", "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", "", "")
call <sid>hi("Statement",    s:gui08, "", "", "")
call <sid>hi("StorageClass", s:gui0A, "", "", "")
call <sid>hi("String",       s:gui0B, "", "", "")
call <sid>hi("Structure",    s:gui0E, "", "", "")
call <sid>hi("Tag",          s:gui0A, "", "", "")
call <sid>hi("Todo",         s:gui0A, s:gui01, "", "")
call <sid>hi("Type",         s:gui0A, "", "none", "")
call <sid>hi("Typedef",      s:gui0A, "", "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", "", "")

" C# highlighting
call <sid>hi("csClass",                 s:gui0A, "", "", "")
call <sid>hi("csAttribute",             s:gui0A, "", "", "")
call <sid>hi("csModifier",              s:gui0E, "", "", "")
call <sid>hi("csType",                  s:gui08, "", "", "")
call <sid>hi("csUnspecifiedStatement",  s:gui0D, "", "", "")
call <sid>hi("csContextualStatement",   s:gui0E, "", "", "")
call <sid>hi("csNewDecleration",        s:gui08, "", "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", "", "")
call <sid>hi("cssClassName",   s:gui0E, "", "", "")
call <sid>hi("cssColor",       s:gui0C, "", "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui01, "", "")
call <sid>hi("DiffChange",   s:gui03, s:gui01, "", "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01, "", "")
call <sid>hi("DiffText",     s:gui0D, s:gui01, "", "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00, "", "")
call <sid>hi("DiffFile",     s:gui08, s:gui00, "", "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00, "", "")
call <sid>hi("DiffLine",     s:gui0D, s:gui00, "", "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00, "", "")

" Git highlighting
call <sid>hi("gitcommitOverflow",       s:gui08, "", "", "")
call <sid>hi("gitcommitSummary",        s:gui0B, "", "", "")
call <sid>hi("gitcommitComment",        s:gui03, "", "", "")
call <sid>hi("gitcommitUntracked",      s:gui03, "", "", "")
call <sid>hi("gitcommitDiscarded",      s:gui03, "", "", "")
call <sid>hi("gitcommitSelected",       s:gui03, "", "", "")
call <sid>hi("gitcommitHeader",         s:gui0E, "", "", "")
call <sid>hi("gitcommitSelectedType",   s:gui0D, "", "", "")
call <sid>hi("gitcommitUnmergedType",   s:gui0D, "", "", "")
call <sid>hi("gitcommitDiscardedType",  s:gui0D, "", "", "")
call <sid>hi("gitcommitBranch",         s:gui09, "", "bold", "")
call <sid>hi("gitcommitUntrackedFile",  s:gui0A, "", "", "")
call <sid>hi("gitcommitUnmergedFile",   s:gui08, "", "bold", "")
call <sid>hi("gitcommitDiscardedFile",  s:gui08, "", "bold", "")
call <sid>hi("gitcommitSelectedFile",   s:gui0B, "", "bold", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, "", "", "")
call <sid>hi("GitGutterChange",  s:gui0A, "", "", "")
call <sid>hi("GitGutterDelete",  s:gui08, "", "", "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, "", "", "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", "", "")
call <sid>hi("htmlTag",     s:gui05, "", "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", "", "")
" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          s:gui0D, "", "", "")
call <sid>hi("jsStatement",         s:gui0E, "", "", "")
call <sid>hi("jsReturn",            s:gui0E, "", "", "")
call <sid>hi("jsThis",              s:gui08, "", "", "")
call <sid>hi("jsClassDefinition",   s:gui0A, "", "", "")
call <sid>hi("jsFunction",          s:gui0E, "", "", "")
call <sid>hi("jsFuncName",          s:gui0D, "", "", "")
call <sid>hi("jsFuncCall",          s:gui0D, "", "", "")
call <sid>hi("jsClassFuncName",     s:gui0D, "", "", "")
call <sid>hi("jsClassMethodType",   s:gui0E, "", "", "")
call <sid>hi("jsRegexpString",      s:gui0C, "", "", "")
call <sid>hi("jsGlobalObjects",     s:gui0A, "", "", "")
call <sid>hi("jsGlobalNodeObjects", s:gui0A, "", "", "")
call <sid>hi("jsExceptions",        s:gui0A, "", "", "")
call <sid>hi("jsBuiltins",          s:gui0A, "", "", "")

" LSP
call <sid>hi("LspReferenceText"                   ,"",     "", "underline", s:gui04 )
call <sid>hi("LspReferenceRead"                   ,"",     "", "underline", s:gui04 )
call <sid>hi("LspReferenceWrite"                  ,"",     "", "underline", s:gui04 )
call <sid>hi("LspDiagnosticsDefaultError"         ,s:gui08, "", "none",      ""     )
call <sid>hi("LspDiagnosticsDefaultWarning"       ,s:gui09, "", "none",      ""     )
call <sid>hi("LspDiagnosticsDefaultInformation"   ,s:gui05, "", "none",      ""     )
call <sid>hi("LspDiagnosticsDefaultHint"          ,s:gui0C, "", "none",      ""     )
call <sid>hi("LspDiagnosticsUnderlineError"       ,"",     "", "undercurl", s:gui08 )
call <sid>hi("LspDiagnosticsUnderlineWarning"     ,"",     "", "undercurl", s:gui09 )
call <sid>hi("LspDiagnosticsUnderlineInformation" ,"",     "", "undercurl", s:gui0F )
call <sid>hi("LspDiagnosticsUnderlineHint"        ,"",     "", "undercurl", s:gui0C )

" Mail highlighting
call <sid>hi("mailQuoted1",  s:gui0A, "", "", "")
call <sid>hi("mailQuoted2",  s:gui0B, "", "", "")
call <sid>hi("mailQuoted3",  s:gui0E, "", "", "")
call <sid>hi("mailQuoted4",  s:gui0C, "", "", "")
call <sid>hi("mailQuoted5",  s:gui0D, "", "", "")
call <sid>hi("mailQuoted6",  s:gui0A, "", "", "")
call <sid>hi("mailURL",      s:gui0D, "", "", "")
call <sid>hi("mailEmail",    s:gui0D, "", "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", "", "")
call <sid>hi("markdownError",             s:gui05, s:gui00, "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", "", "")
call <sid>hi("phpComparison",      s:gui05, "", "", "")
call <sid>hi("phpParent",          s:gui05, "", "", "")
call <sid>hi("phpMethodsVar",      s:gui0C, "", "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui0E, "", "", "")
call <sid>hi("pythonRepeat",    s:gui0E, "", "", "")
call <sid>hi("pythonInclude",   s:gui0E, "", "", "")
call <sid>hi("pythonStatement", s:gui0E, "", "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", "", "")
call <sid>hi("sassClassChar",  s:gui09, "", "", "")
call <sid>hi("sassInclude",    s:gui0E, "", "", "")
call <sid>hi("sassMixing",     s:gui0E, "", "", "")
call <sid>hi("sassMixinName",  s:gui0D, "", "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", "", "undercurl", s:gui08)
call <sid>hi("SpellLocal",   "", "", "undercurl", s:gui0C)
call <sid>hi("SpellCap",     "", "", "undercurl", s:gui0D)
call <sid>hi("SpellRare",    "", "", "undercurl", s:gui0E)

" Startify highlighting
call <sid>hi("StartifyBracket",  s:gui03, "", "", "")
call <sid>hi("StartifyFile",     s:gui07, "", "", "")
call <sid>hi("StartifyFooter",   s:gui03, "", "", "")
call <sid>hi("StartifyHeader",   s:gui0B, "", "", "")
call <sid>hi("StartifyNumber",   s:gui09, "", "", "")
call <sid>hi("StartifyPath",     s:gui03, "", "", "")
call <sid>hi("StartifySection",  s:gui0E, "", "", "")
call <sid>hi("StartifySelect",   s:gui0C, "", "", "")
call <sid>hi("StartifySlash",    s:gui03, "", "", "")
call <sid>hi("StartifySpecial",  s:gui03, "", "", "")

" Java highlighting
call <sid>hi("javaOperator",     s:gui0D, "", "", "")

" Treesitter
call <sid>hi("TSAnnotation"         ,s:gui0F, "",             "none",             ""     )
call <sid>hi("TSAttribute"          ,s:gui0A, "",             "none",             ""     )
call <sid>hi("TSBoolean"            ,s:gui09, "",             "none",             ""     )
call <sid>hi("TSCharacter"          ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSComment"            ,s:gui10, "",             "italic",           ""     )
call <sid>hi("TSConstructor"        ,s:gui0D, "",             "none",             ""     )
call <sid>hi("TSConditional"        ,s:gui0E, "",             "none",             ""     )
call <sid>hi("TSConstant"           ,s:gui09, "",             "none",             ""     )
call <sid>hi("TSConstBuiltin"       ,s:gui09, "",             "italic",           ""     )
call <sid>hi("TSConstMacro"         ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSError"              ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSException"          ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSField"              ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSFloat"              ,s:gui09, "",             "none",             ""     )
call <sid>hi("TSFunction"           ,s:gui0D, "",             "none",             ""     )
call <sid>hi("TSFuncBuiltin"        ,s:gui0D, "",             "italic",           ""     )
call <sid>hi("TSFuncMacro"          ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSInclude"            ,s:gui0D, "",             "none",             ""     )
call <sid>hi("TSKeyword"            ,s:gui0E, "",             "none",             ""     )
call <sid>hi("TSKeywordFunction"    ,s:gui0E, "",             "none",             ""     )
call <sid>hi("TSKeywordOperator"    ,s:gui0E, "",             "none",             ""     )
call <sid>hi("TSLabel"              ,s:gui0A, "",             "none",             ""     )
call <sid>hi("TSMethod"             ,s:gui0D, "",             "none",             ""     )
call <sid>hi("TSNamespace"          ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSNone"               ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSNumber"             ,s:gui09, "",             "none",             ""     )
call <sid>hi("TSOperator"           ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSParameter"          ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSParameterReference" ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSProperty"           ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSPunctDelimiter"     ,s:gui0F, "",             "none",             ""     )
call <sid>hi("TSPunctBracket"       ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSPunctSpecial"       ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSRepeat"             ,s:gui0A, "",             "none",             ""     )
call <sid>hi("TSString"             ,s:gui0B, "",             "none",             ""     )
call <sid>hi("TSStringRegex"        ,s:gui0C, "",             "none",             ""     )
call <sid>hi("TSStringEscape"       ,s:gui0C, "",             "none",             ""     )
call <sid>hi("TSSymbol"             ,s:gui0B, "",             "none",             ""     )
call <sid>hi("TSTag"                ,s:gui0A, "",             "none",             ""     )
call <sid>hi("TSTagDelimiter"       ,s:gui0F, "",             "none",             ""     )
call <sid>hi("TSText"               ,s:gui05, "",             "none",             ""     )
call <sid>hi("TSStrong"             ,"",      "",             "bold",             ""     )
call <sid>hi("TSEmphasis"           ,s:gui09, "",             "italic",           ""     )
call <sid>hi("TSUnderline"          ,s:gui00, "",             "underline",        ""     )
call <sid>hi("TSStrike"             ,s:gui00, "",             "strikethrough",    ""     )
call <sid>hi("TSTitle"              ,s:gui0D, "",             "none",             ""     )
call <sid>hi("TSLiteral"            ,s:gui09, "",             "none",             ""     )
call <sid>hi("TSURI"                ,s:gui09, "",             "underline",        ""     )
call <sid>hi("TSType"               ,s:gui0A, "",             "none",             ""     )
call <sid>hi("TSTypeBuiltin"        ,s:gui0A, "",             "italic",           ""     )
call <sid>hi("TSVariable"           ,s:gui08, "",             "none",             ""     )
call <sid>hi("TSVariableBuiltin"    ,s:gui08, "",             "italic",           ""     )
call <sid>hi("TSDefinition"         ,"",      "",             "underline",        s:gui04 )
call <sid>hi("TSDefinitionUsage"    ,"",      "",             "underline",        s:gui04 )
call <sid>hi("TSCurrentScope"       ,"",      "",             "bold",             ""     )
call <sid>hi("NvimInternalError"    ,s:gui00, s:gui08,         "none",             ""     )
call <sid>hi("TreesitterContext"    ,"",     s:gui01,         "italic",           ""     )

" Telescope
call <sid>hi("TelescopeSelection", "", s:gui11, "none", "")

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07
			\ s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
			\ s:gui10 s:gui11

highlight clear SignColumn
