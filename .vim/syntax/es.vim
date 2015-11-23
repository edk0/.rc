" VIM syntax for extensible shell
" Language:   Extensible shell (es) script
" Maintainer: Kacper Gutowski <mwgamera@gmail.com>

syntax clear " FIXME

if exists("b:current_syntax")
  finish
endif

setl iskeyword=34,%,*,+,44-58,?,[,],_,A-Z,a-z

syn cluster esKeyword contains=esClosure,esFn,esFor,esLet,esLocal

syn keyword esClosure %closure
syn keyword esFn      fn
syn keyword esFor     for
syn keyword esLet     let
syn keyword esLocal   local

syn cluster esBody contains=esString,esBlock,esList,esVariableRef,esBadVariableRef,esPrimitive,esComment,esOperator,esRedirNum,esSpecialChar,esBadSpecialChar,esWrapLine,@esKeyword,

syn region esString matchgroup=esOperator start=/'/ skip=/''/ end=/'/
syn region esBlock  matchgroup=esOperator start=/{/ end=/}/ contains=@esBody
syn region esList   matchgroup=esOperator start=/(/ end=/)/ contains=@esBody

syn match esVariableName /\<["%*+,./0-9?A-Za-z\[\]_-]\+\>/ contained
syn match esVariableRef /\$[#^]\?[0-9A-Za-z%*_-]*/
syn match esBadVariableRef /\$[#^]\?\(\s\|$\|[#^]\{2,}\|[+@.]\)/

syn match esPrimitive /\$&\(access\|and\|apids\|append\|background\|backquote\|batchloop\|catch\|cd\|close\|collect\|count\|create\|dot\|dup\|echo\|eval\|exec\|execfailure\|exit\|exitonfalse\|false\|flatten\|forever\|fork\|fsplit\|here\|home\|if\|internals\|isinteractive\|isnoexport\|limit\|newfd\|newpgrp\|noexport\|noreturn\|not\|one\|open\|openfile\|or\|parse\|pathsearch\|pipe\|primitives\|read\|readfrom\|resetterminal\|result\|run\|seq\|sethistory\|setmaxevaldepth\|setnoexport\|setprompt\|setsignals\|split\|throw\|time\|true\|umask\|unwindprotect\|var\|vars\|version\|wait\|whatis\|while\|writeto\)/

syn match esComment /#.*$/ contains=esTodo
syn keyword esTodo contained FIXME TODO NOTE XXX

syn match esOperator /[!&*;<>=?@^|]/
syn match esRedirNum /[<>|]\[[0-9]\+\(=[0-9]*\)\?\]/

syn match esSpecialChar /\(\\[Xx]0*[1-9A-Fa-f]\x*\|\\0*[1-7]\o*\|\\.\)/
syn match esBadSpecialChar /\(\\[89A-WYZcdg-mo-qsu-wyz]\|\\[Xx]0*\x\@!\|\\0\+\o\@!\)/

syn match esWrapLine /\\$/


hi def link esComment         Comment
hi def link esTodo            Todo
hi def link esString          String

hi def link esOperator        Operator
hi def link esRedirNum        Operator

hi def link esSpecialChar     SpecialChar
hi def link esBadSpecialChar  Error

hi def link esWrapLine        Operator

hi def link esVariableName    Identifier
hi def link esVariableRef     Identifier
hi def link esBadVariableRef  Error
hi def link esPrimitive       Special

hi def link esFn    Keyword
hi def link esLocal Keyword
hi def link esLet   Keyword
hi def link esFor   Keyword
hi def link esClosure   Keyword

let b:current_syntax = "es"
