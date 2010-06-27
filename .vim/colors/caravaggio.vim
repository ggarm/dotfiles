" -----------------------------------------------------------------------------
" Caravaggio -- A Vim color theme file
" Who is Caravaggio? Visit "en.wikipedia.org/caravaggio"
" -----------------------------------------------------------------------------
" Creator: Guan 'kuno' Qing <neokuno AT gmail DOT com>
" Last Change: 2010-01-20 12:58:31
" -----------------------------------------------------------------------------

set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "caravaggio"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine         guibg=#2d2d2d
  hi CursorColumn       guibg=#2d2d2d
  hi MatchParen         guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	        guifg=#000000 guibg=#cae682
endif

" General colors
hi Cursor 		guifg=NONE    guibg=#cccccc gui=none
hi CursorColumm         guifg=#ffdd55 gui=none
hi Normal 		guifg=#f2efe6 guibg=#282831 gui=none
hi NonText 		guifg=#808080 guibg=#303030 gui=none
hi LineNr 		guifg=#888888 guibg=#232323 gui=none
hi StatusLine 	        guifg=#ffffff guibg=#444444 gui=bold
hi StatusLineNC         guifg=#857b6f guibg=#444444 gui=none
hi VertSplit 	        guifg=#444444 guibg=#444444 gui=none
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
hi Title		guifg=#f6f3e8 guibg=NONE    gui=bold
hi Visual		guifg=#f6f3e8 guibg=#444444 gui=none
hi SpecialKey	        guifg=#808080 guibg=#343434 gui=none
hi WarningMsg           guifg=#ffffff gui=none
hi ErrorMsg             guifg=#ffffff guibg=#282831

" Syntax highlighting
hi Function             guifg=#40bce6 gui=bold
hi Boolean              guifg=#e62e8a gui=bold
hi Character            guifg=#abc837 gui=none
hi Define               guifg=#ffe680 gui=bold
hi Delimiter            guifg=#e6923e gui=none
hi Exception            guifg=#a673b1 gui=bold
hi Float                guifg=#2ed2e8 gui=bold
hi Directory            guifg=#a9d96c gui=bold
hi Operator             guifg=#d9d200 gui=bold
hi Conditional          guifg=#d92184 gui=bold
hi Comment 		guifg=#666666 gui=italic
hi Todo 		guifg=#8f8f8f gui=italic
hi Constant 	        guifg=#ebb34c gui=bold
hi String 		guifg=#bde090 gui=italic
hi Identifier 	        guifg=#ad539a gui=bold
hi Type 		guifg=#1b9992 gui=bold
hi TypeDef              guifg=#c71585 gui=bold
hi Statement 	        guifg=#d6283e gui=bold
hi Keyword		guifg=#abd837 gui=none
hi PreCondit            guifg=#008080 gui=bold
hi PreProc 		guifg=#3199b6 gui=bold
hi Number		guifg=#b4e05a gui=bold
hi Repeat               guifg=#d92184 gui=bold
hi Search               guifg=#888888 guibg=#ebf051
hi Special		guifg=#dfeccb gui=bold
hi SpecialChar          guifg=#ff80b2 gui=bold
hi Structure            guifg=#cf3acd gui=bold
hi Macro                guifg=#e6c74c gui=bold
hi Compare              guifg=#eb4141 gui=bold 
hi Pointer              guifg=#9dac93 gui=bold
" hi Include
