if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword to times loop while if else elsif else class
			\ return
syntax keyword potionFunction print join string

syntax match potionComment "\v#.*$"
syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\="
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="
syntax match potionNumber "\v0x(\d+|\x+)|\d+\.?\d*e?-?|\+?\d+"

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region potionStringSQ start=/\v'/ skip=/\v\\./ end=/\v'/

highlight link potionKeyword Keyword
highlight link potionFunction Function
highlight link potionComment Comment
highlight link potionOperator Operator
highlight link potionNumber Number
highlight link potionString String
highlight link potionStringSQ String

let b:current_syntax = "potion"
