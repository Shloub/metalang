%{
	module E = Expr
	module M = Mutable
	module I = Instr
	module T = Type
	module P = Prog
%}

%token MAIN IF THEN ELSE ELSIF END DO FOR TO WHILE RETURN
%token DEF MACRO WITH
%token READ PRINT SKIP
%token ENUM RECORD
%token SET DOT COMMA PERIOD
%token LEFT_PARENS RIGHT_PARENS LEFT_BRACKET RIGHT_BRACKET
%token NOT AND OR
%token EQUAL NOT_EQUAL LOWER HIGHER LOWER_OR_EQUAL HIGHER_OR_EQUAL
%token ADD NEG MUL DIV MODULO
%token TYPE_INT TYPE_FLOAT TYPE_CHAR TYPE_BOOL TYPE_ARRAY TYPE_VOID
%token TRUE FALSE
%token<int> INT
%token<char> CHAR
%token<string> STRING
%token<string> IDENT
%token EOF

%left OR
%left AND

%left NOT_EQUAL EQUAL HIGHER_OR_EQUAL HIGHER LOWER_OR_EQUAL LOWER

%left ADD NEG
%left MUL DIV MODULO

%left NOT

%start prog toplvls toplvl_expr
%type<Prog.t_fun list * Instr.t list option> prog
%type<Prog.t_fun list> toplvls
%type<Expr.t> toplvl_expr
%%

prog :
| define* main EOF { $1, $2 }
;

toplvls : define* EOF { $1 } ;
toplvl_expr : expr EOF { $1 } ;

main :
| { None }
| MAIN instrs END { Some $2 }
;

value :
| TRUE  { E.bool true }
| FALSE { E.bool false }
| INT   { E.integer $1 }
| CHAR  { E.char $1 }
;

typ :
| TYPE_INT { T.integer }
| TYPE_FLOAT { T.float }
| TYPE_CHAR { T.char }
| TYPE_BOOL { T.bool }
| TYPE_ARRAY LOWER typ HIGHER { T.array $3 }
| TYPE_VOID { T.void }
;

expr :
| value { $1 }
| mutabl { E.access $1 }
| LEFT_PARENS expr RIGHT_PARENS { $2 }
| unary_op  { $1 }
| binary_op { $1 }
| IDENT LEFT_PARENS exprs RIGHT_PARENS { E.call $1 $3 }
;

mutabl :
| IDENT { M.var $1 }
| mutabl LEFT_BRACKET exprs RIGHT_BRACKET { M.array $1 $3 }
;

exprs :
| { [] }
| expr { [$1] }
| expr COMMA exprs { $1 :: $3 }
;

%inline
unop :
| NOT { E.Not }
| NEG { E.Neg }
;

unary_op :
| x=unop y=expr %prec NOT { E.unop x y }
;

binary_op :
| e1=expr op=binop e2=expr { E.binop op e1 e2 }
;

%inline binop :
| ADD { E.Add }
| NEG { E.Sub }
| MUL { E.Mul }
| DIV { E.Div }
| MODULO { E.Mod }
| AND { E.And }
| OR  { E.Or  }
| EQUAL { E.Eq }
| NOT_EQUAL { E.Diff }
| HIGHER { E.Higher }
| LOWER  { E.Lower }
| HIGHER_OR_EQUAL { E.HigherEq }
| LOWER_OR_EQUAL  { E.LowerEq }
;


define_var :
| DEF typ IDENT SET expr { I.declare $3 $2 $5 }
| DEF typ IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
	{ match T.unfix $2 with
	  | T.Array x -> I.alloc_array_lambda $3 x $5 $8 $10
		| _ -> failwith "expected array"
	}
| DEF READ typ IDENT { I.readdecl $3 $4 }
;

cond :
| expr THEN instrs ELSE instrs END { I.if_ $1 $3 $5 }
| expr THEN instrs END { I.if_ $1 $3 [] }
| expr THEN instrs ELSIF cond { I.if_ $1 $3 [$5] }
;

control_flow :
| IF cond { $2 }
| FOR IDENT SET expr TO expr DO instrs END { I.loop $2 $4 $6 $8 }
| WHILE expr DO instrs END { I.while_ $2 $4 }
| RETURN expr { I.return $2 }
| IDENT LEFT_PARENS exprs RIGHT_PARENS { I.call $1 $3 }
;

instr :
| define_var { $1 }
| control_flow { $1 }
| mutabl SET expr { I.affect $1 $3 }
| READ typ mutabl { I.read $2 $3 }
| PRINT typ expr { I.print $2 $3 }
| SKIP { I.stdin_sep }
;

instrs :
| { [] }
| instr PERIOD? instrs { $1 :: $3 }
;

arg :
| typ IDENT { $2, $1 }
;

args :
| { [] }
| arg { [$1] }
| arg COMMA args { $1 :: $3 }
;

define :
| DEF typ IDENT LEFT_PARENS args RIGHT_PARENS instrs END
	{ P.declarefun $3 $2 $5 $7 }

| MACRO typ IDENT LEFT_PARENS args RIGHT_PARENS macro* END
	{ P.macro $3 $2 $5 $7 }
;

macro :
| ident_language DO STRING PERIOD? { $1, $3 }
;

ident_language :
| IDENT { $1 }
| MUL { "" }
;

(*
def_type :
| ENUM NAME ... END
| RECORD NAME ... END
;
*)

