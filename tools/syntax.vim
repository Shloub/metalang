" ViM Syntax File
" Language: metalang
" Install: copy into ~/.vim/syntax/

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "metalang"

syn keyword mKEYWORD main def macro end if then else while for to with do return record elsif
syn keyword mPRIMITIVE read print skip
syn keyword mTYPE int char bool void string array
syn match   mTYPE '@\S\+'
syn match   mVALUE '-\?\d\+'

syn region mCOMMENT start='/\*' end='\*/'

syn region mVALUE start='"' end='"'

hi def link mKEYWORD   Keyword
hi def link mPRIMITIVE Todo
hi def link mTYPE      Type
hi def link mVALUE     Constant
hi def link mCOMMENT     Comment
