%{
  open Stdlib
	module E = Ast.Expr
	module M = Ast.Mutable
	module I = Ast.Instr
	module T = Ast.Type
	module P = Ast.Prog


  let locate pos e =
    let () = Ast.PosMap.add (E.Fixed.annot e) pos
    in e
  let locati pos e =
    let () = Ast.PosMap.add (I.Fixed.annot e) pos
    in e
  let locatm pos e =
    let () = Ast.PosMap.add (M.Fixed.annot e) pos
    in e
%}

%token MAIN IF THEN ELSE ELSIF END DO FOR TO WHILE RETURN
%token DEF MACRO WITH
%token READ PRINT SKIP
%token ENUM RECORD
%token SET DOT COMMA PERIOD COLON AT
%token LEFT_PARENS RIGHT_PARENS LEFT_BRACKET RIGHT_BRACKET
%token NOT AND OR
%token EQUAL NOT_EQUAL LOWER HIGHER LOWER_OR_EQUAL HIGHER_OR_EQUAL
%token ADD NEG MUL DIV MODULO
%token TYPE_INT TYPE_AUTO TYPE_STRING TYPE_FLOAT TYPE_CHAR TYPE_BOOL TYPE_ARRAY TYPE_VOID
%token TRUE FALSE
%token<int> INT
%token<char> CHAR
%token<string> STRING
%token<string> IDENT
%token<token list> LEXEMS
%token EOF
%token END_QUOTE

%left OR
%left AND

%left NOT_EQUAL EQUAL HIGHER_OR_EQUAL HIGHER LOWER_OR_EQUAL LOWER

%left ADD NEG
%left MUL DIV MODULO

%left NOT

%start prog toplvls toplvl_expr
%type<token Ast.Prog.t_fun list * token Ast.Instr.t list option> prog
%type<token Ast.Prog.t_fun list> toplvls
%type<token Ast.Expr.t> toplvl_expr
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
| STRING  { E.string $1 }
;

typ :
| TYPE_STRING { T.string }
| TYPE_INT { T.integer }
| TYPE_AUTO { T.auto () }
| TYPE_FLOAT { T.float }
| TYPE_CHAR { T.char }
| TYPE_BOOL { T.bool }
| TYPE_ARRAY LOWER typ HIGHER { T.array $3 }
| TYPE_VOID { T.void }
| AT IDENT { T.named $2 }
;

expr :
| value { $1 |> locate ( Ast.location ($startpos($1), $endpos($1))) }
| mutabl
    { E.access $1 |>
        locate ( Ast.location ($startpos($1), $endpos($1))) }
| LEFT_PARENS expr RIGHT_PARENS
    { $2 |> locate ( Ast.location ($startpos($1), $endpos($3))) }
| unary_op  { $1 |> locate ( Ast.location ($startpos($1), $endpos($1))) }
| binary_op { $1 |> locate ( Ast.location ($startpos($1), $endpos($1))) }
| IDENT LEFT_PARENS exprs RIGHT_PARENS
{
  E.call $1 $3
    |> locate ( Ast.location ($startpos($1), $endpos($4)))
}
| LEXEMS { E.lexems $1 }
;

mutabl :
| IDENT { M.var $1  |> locatm ( Ast.location ($startpos($1), $endpos($1))) }
| mutabl LEFT_BRACKET exprs RIGHT_BRACKET
    { M.array $1 $3  |> locatm ( Ast.location ($startpos($1), $endpos($4))) }
| mutabl DOT IDENT
        { M.fix (M.Dot ($1, $3))
            |> locatm ( Ast.location ($startpos($1), $endpos($3)))  }
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

affect_field :
| IDENT SET expr PERIOD? { ($1, $3) }
;

alloc_record :
| DEF IDENT SET RECORD affect_field* END
    { I.alloc_record $2 (T.auto ()) $5 }
| DEF typ IDENT SET RECORD affect_field* END
    { I.alloc_record $3 $2 $6 }
;

define_var :
| DEF IDENT SET expr { I.declare $2 (T.auto ()) $4 }
| DEF typ IDENT SET expr { I.declare $3 $2 $5 }
| DEF IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
    { I.alloc_array_lambda $2 (T.auto ()) $4 $7 $9 }
| DEF typ IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
	{ match T.unfix $2 with
	  | T.Array x -> I.alloc_array_lambda $3 x $5 $8 $10
    | T.Auto -> I.alloc_array_lambda $3 $2 $5 $8 $10
		| _ -> failwith "expected array"
	}
| DEF READ IDENT { I.readdecl (T.auto ()) $3 }
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
| define_var { $1
        |> locati ( Ast.location ($startpos($1), $endpos($1)))}
| control_flow { $1 |> locati ( Ast.location ($startpos($1), $endpos($1))) }
| mutabl SET expr { I.affect $1 $3
                      |> locati ( Ast.location ($startpos($1), $endpos($3)))
                  }
| READ typ mutabl { I.read $2 $3
                      |> locati ( Ast.location ($startpos($1), $endpos($3)))
                  }
| PRINT expr { I.print (T.auto ()) $2
                 |> locati ( Ast.location ($startpos($1), $endpos($2)))
             }
| PRINT typ expr { I.print $2 $3
                 |> locati ( Ast.location ($startpos($1), $endpos($3)))
                 }
| SKIP { I.stdin_sep ()
       |> locati ( Ast.location ($startpos($1), $endpos($1)))
       }
| alloc_record { $1
                   |> locati ( Ast.location ($startpos($1), $endpos($1)))
               }
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

| RECORD AT IDENT decl_field* END
    { P.DeclareType ($3, (T.struct_ $4 {T.tuple = false} )) }
;

decl_field :
| IDENT COLON typ PERIOD? { $1, $3 }
;

macro :
| ident_language DO STRING PERIOD? { $1, $3 }
;

ident_language :
| IDENT { $1 }
| MUL { "" }
;
