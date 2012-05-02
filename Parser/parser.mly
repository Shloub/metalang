/*
* Copyright (c) 2012, Prologin
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*/



%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <char> CHAR
%token <bool> BOOL
%token <string> NAME

%token MACRO
%token SPACING
%token LBRACE
%token RBRACE
%token LHOOK
%token RHOOK
%token LPARENT
%token RPARENT
%token COMMA
%token DOTCOMMA
%token PROG
%token RETURN
%token IF
%token ELSE
%token PRINT
%token READ
%token <string>COMMENT
%token FOR
%token WHILE
%token TO

%token O_ADD
%token O_NEG
%token O_MUL
%token O_DIV
%token O_MOD
%token O_OR
%token O_AND
%token O_NOT
%token O_BOR
%token O_BAND
%token O_BNOT
%token O_BRSHIFT
%token O_BLSHIFT

%token O_LOWER
%token O_LOWEREQ
%token O_HIGHER
%token O_HIGHEREQ
%token O_EQ
%token O_DIFF

%token STDINSEP

%token AFFECT
%token ARRAY
%token ARROW
%token DECLTYPE
%token STRUCT
%token DOUBLEPOINT
%token EXTERN
%token GLOBAL

%token <Type.t> TYPE

%token EOF

%left TOKENKEXISTEPASLOL

%left SPACING
%left INT
%left LPARENT
%left RPARENT
%left LHOOK
%left RHOOK
%left LBRACE
%left RBRACE

%left O_NOT

%left O_AND
%left O_OR

%left O_DIFF
%left O_EQ

%left O_BOR
%left O_BAND
%left O_BNOT

%left O_HIGHEREQ
%left O_HIGHER
%left O_LOWEREQ
%left O_LOWER
%left O_BRSHIFT
%left O_BLSHIFT
%left O_ADD
%left O_NEG
%left O_BNEG
%left O_MOD
%left O_DIV
%left O_MUL

%left IF
%left ELSE


%left COMMENT

%start main result functions
%type <Prog.t_fun list * Instr.t list option> main
%type <Prog.t_fun list> functions
%type <Expr.t> result
%type <Type.t> type
%%

eof : EOF { () } ;

int :
  INT { Expr.integer $1 } ;

char :
  CHAR { Expr.char $1 } ;

bool :
  BOOL { Expr.bool $1 } ;

string :
  STRING { Expr.string (Stdlib.String.unescape $1) } ;

arrayaccess:
		 |  LBRACE result RBRACE { [$2] }
		 | LBRACE result RBRACE arrayaccess  {$2 :: $4}

result:
| result O_MUL result { Expr.binop Expr.Mul $1 $3 }
| result O_DIV result { Expr.binop Expr.Div $1 $3 }
| result O_MOD result { Expr.binop Expr.Mod $1 $3 }
| result O_ADD result { Expr.binop Expr.Add $1 $3 }
| result O_NEG result { Expr.binop Expr.Sub $1 $3 }
| result O_BLSHIFT result { Expr.binop Expr.LShift $1 $3 }
| result O_BRSHIFT result { Expr.binop Expr.RShift $1 $3 }
| result O_LOWER result { Expr.binop Expr.Lower $1 $3 }
| result O_LOWEREQ result { Expr.binop Expr.LowerEq $1 $3 }
| result O_HIGHER result { Expr.binop Expr.Higher $1 $3 }
| result O_HIGHEREQ result { Expr.binop Expr.HigherEq $1 $3 }
| result O_EQ result { Expr.binop Expr.Eq $1 $3 }
| result O_DIFF result { Expr.binop Expr.Diff $1 $3 }
| result O_BAND result { Expr.binop Expr.BinAnd $1 $3 }
| result O_BOR result { Expr.binop Expr.BinOr $1 $3 }
| result O_OR result { Expr.binop Expr.Or $1 $3 }
| result O_AND result { Expr.binop Expr.And $1 $3 }
| O_NEG result { Expr.unop Expr.Neg $2 }
| O_BNOT result { Expr.unop Expr.BNot $2 }
| O_NOT result { Expr.unop Expr.Not $2 }
| LPARENT result RPARENT { $2 }
| int { $1 }
| bool { $1 }
| string { $1 }
| char { $1 }
| NAME arrayaccess { Expr.access_array $1 $2 }
| NAME { Expr.binding $1 }
| SPACING result { $2 }
| result SPACING { $1 }
| NAME LPARENT params RPARENT { Expr.call $1 $3 }
| NAME LPARENT RPARENT { Expr.call $1 [] }

;


params:
  | result { [$1] }
  | result COMMA params { $1 :: $3 }


type:
  | type ARRAY { Type.array $1 }
  | TYPE { $1 } 

mutable_:
  | NAME { Instr.mutable_var $1 }
  | NAME arrayaccess { Instr.mutable_array $1 $2}

if_:
| IF LPARENT result RPARENT bloc ELSE bloc { Instr.if_ $3 $5 $7 }
| IF LPARENT result RPARENT bloc { Instr.if_ $3 $5 [] }

comment:
| COMMENT { Instr.comment $1; } ;

instruction:
|  mutable_ AFFECT result DOTCOMMA { Instr.affect $1 $3 }
| RETURN result DOTCOMMA { Instr.return $2 }
| type NAME LBRACE result RBRACE
LPARENT NAME ARROW instructions RPARENT DOTCOMMA
{
match $1 with
  | Type.F (Type.Array t) ->
    Instr.alloc_array_lambda $2 t $4 $7 $9
  | _ -> raise Parsing.Parse_error
  (* TODO ajouter un message *)
}
| type NAME LBRACE result RBRACE DOTCOMMA
{
match $1 with
  | Type.F (Type.Array t) ->
    Instr.alloc_array $2 t $4
  | _ -> raise Parsing.Parse_error
  (* TODO ajouter un message*)
}
| NAME LPARENT RPARENT DOTCOMMA { Instr.call $1 [] }
| NAME LPARENT params RPARENT DOTCOMMA { Instr.call $1 $3 }
| type NAME AFFECT result DOTCOMMA { Instr.declare $2 $1 $4 }
| if_ {$1}
| PRINT O_LOWER type O_HIGHER LPARENT result RPARENT DOTCOMMA {
      Instr.print $3 $6
    }
| READ O_LOWER type O_HIGHER LPARENT mutable_ RPARENT DOTCOMMA {
      Instr.read $3 $6
}
| READ type NAME DOTCOMMA {
  Instr.readdecl $2 $3
}
| FOR NAME AFFECT result TO result bloc
{ Instr.loop $2 $4 $6 $7 }
| WHILE LPARENT result RPARENT bloc
{ Instr.while_ $3 $5 }
| STDINSEP { Instr.stdin_sep }

instructions:
| instruction comments { $1 :: $2 }
| instruction { [$1] }
| instruction instructions { $1 :: $2 }
| comments instructions { List.append $1 $2}
;

comments:
| comment comments { $1 :: $2 }
| comment { [$1] }

one_instruction:
| comments one_instruction { List.append $1 $2 }
| instruction comments { $1 :: $2 }
| instruction { [$1] }
 
param_list:
| type NAME { [($2, $1)] }
| type NAME COMMA param_list { ($2, $1) :: $4 }

bloc:
    | LHOOK instructions RHOOK { $2 } ;
    | LHOOK RHOOK { [] } ;
    | one_instruction { $1 }
    | LHOOK comments RHOOK { $2 }

main_prog:
  PROG bloc EOF { Some $2 } ;
    | EOF { None };

function_:
    | type NAME LPARENT param_list RPARENT bloc {
      Prog.declarefun $2 $1 $4 $6 }
    | type NAME LPARENT RPARENT bloc {
      Prog.declarefun $2 $1 [] $5 } ;

macro_content_:
	| NAME ARROW STRING DOTCOMMA { ($1, $3) }
	| O_MUL ARROW STRING DOTCOMMA { ("", $3) };

macro_content:
	| macro_content_ { [$1] }
	| macro_content_ macro_content { $1 :: $2 };
macro:
	| MACRO type NAME LPARENT param_list RPARENT LHOOK macro_content RHOOK {
	  Prog.macro $3 $2 $5 $8
	};

functions:
	| COMMENT { [Prog.comment $1 ]}
	| COMMENT functions { (Prog.comment $1) :: $2}
	| macro { [$1] }
	| function_ { [$1] }
	| function_ functions { $1::$2 }
	| macro functions { $1::$2 };
prog:
    | functions main_prog { ( $1, $2) }
    | main_prog { ([], $1) }
;

main:
  prog eof { $1 }
;
