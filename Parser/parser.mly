%{

open Ext
module E = Ast.Expr
module M = Ast.Mutable
module I = Ast.Instr
module T = Ast.Type
module P = Ast.Prog

  let locate pos e =
    let () = Ast.PosMap.add (E.Fixed.annot e) pos
    in e

  let locatt pos e =
    let () = Ast.PosMap.add (T.Fixed.annot e) pos
    in e

  let locati pos e =
    let () = Ast.PosMap.add (I.Fixed.annot e) pos
    in e
  let locatm pos e =
    let () = Ast.PosMap.add (M.Fixed.annot e) pos
    in e

let makep p =
    let line = p.Lexing.pos_lnum in
    let cnum = p.Lexing.pos_cnum - p.Lexing.pos_bol - 1 in
    Ast.Location.makep line cnum

let makel a b =
    Ast.Location.make (makep a) (makep b)

%}
%token<string> COMMENT
%token MAIN IF THEN ELSE ELSIF END DO FOR TO WHILE RETURN TAG
%token DEF MACRO WITH USELESS
%token READ PRINT SKIP
%token ENUM RECORD
%token SET DOT COMMA PERIOD COLON AT
%token LEFT_PARENS RIGHT_PARENS LEFT_BRACKET RIGHT_BRACKET
%token NOT AND OR
%token EQUAL NOT_EQUAL LOWER HIGHER LOWER_OR_EQUAL HIGHER_OR_EQUAL
%token ADDON SUBON MULON DIVON INCR DECR
%token ADD NEG MUL DIV MODULO
%token TYPE_INT TYPE_AUTO TYPE_STRING TYPE_CHAR TYPE_BOOL TYPE_ARRAY TYPE_OPTION TYPE_VOID TYPE_LEXEMS
%token TRUE FALSE NIL JUST
%token<int> INT
%token<char> CHAR
%token<string> STRING
%token<string> ENUM_FIELD
%token<string> IDENT
%token<(token, token Ast.Expr.t) Ast.Lexems.t list> LEXEMS
%token UNQUOTE_START
%token EOF
%token END_QUOTE

%left OR
%left AND

%left NOT_EQUAL EQUAL HIGHER_OR_EQUAL HIGHER LOWER_OR_EQUAL LOWER

%left ADD NEG
%left MUL DIV MODULO

%left NOT

%start prog toplvls toplvl_expr toplvl_instrs
%type<token Ast.Prog.t_fun list * token Ast.Expr.t Ast.Instr.t list option> prog
%type<token Ast.Prog.t_fun list> toplvls
%type<token Ast.Expr.t> toplvl_expr
%type<token Ast.Expr.t Ast.Instr.t list> toplvl_instrs
%%

prog :
| define* main EOF { $1, $2 }
;

toplvls : define* EOF { $1 } ;
toplvl_instrs : instrs EOF { $1 } ;
toplvl_expr : expr EOF { $1 } ;

main :
| { None }
| MAIN instrs END { Some $2 }
;

value :
| TRUE  { E.bool true }
| FALSE { E.bool false }
| NIL { E.nil () }
| INT   { E.integer $1 }
| CHAR  { E.char $1 }
| STRING  { E.string $1 }
| ENUM_FIELD { E.enum $1 }
;

typ :
| TYPE_STRING { T.string  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_INT { T.integer  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_LEXEMS   { T.lexems  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_AUTO { T.auto ()  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_CHAR { T.char  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_BOOL { T.bool  |> locatt  ( makel $startpos($1) $endpos($1)) }
| TYPE_ARRAY LOWER typ HIGHER { T.array $3  |> locatt  ( makel $startpos($1) $endpos($3)) }
| TYPE_OPTION LOWER typ HIGHER { T.option $3  |> locatt  ( makel $startpos($1) $endpos($3)) }
| TYPE_VOID { T.void |> locatt  ( makel $startpos($1) $endpos($1)) }
| AT IDENT { T.named $2  |> locatt  ( makel $startpos($1) $endpos($2)) }
| LEFT_PARENS li_typ { T.tuple $2 |> locatt  ( makel $startpos($1) $endpos($2)) }
;

li_typ :
| typ RIGHT_PARENS { [$1] }
| typ COMMA li_typ { $1 :: $3 }
;

expr :
| value { $1 |> locate ( makel $startpos($1) $endpos($1)) }
| mutabl { E.access $1 |> locate ( makel $startpos($1) $endpos($1)) }
| LEFT_PARENS expr RIGHT_PARENS { $2 |> locate ( makel $startpos($1) $endpos($3)) }
| unary_op  { $1 |> locate ( makel $startpos($1) $endpos($1)) }
| binary_op { $1 |> locate ( makel $startpos($1) $endpos($1)) }
| LEFT_PARENS exprs RIGHT_PARENS { E.tuple $2 |> locate ( makel $startpos($1) $endpos($3)) }
| IDENT LEFT_PARENS exprs RIGHT_PARENS { E.call $1 $3 |> locate ( makel $startpos($1) $endpos($4)) }
| LEXEMS { E.lexems $1 |> locate ( makel $startpos($1) $endpos($1)) }
| RECORD affect_field* END {E.record $2 |> locate ( makel $startpos($1) $endpos($1))}
| JUST expr { E.just $2 |> locate ( makel $startpos($1) $endpos($2)) }
;

mutabl :
| IDENT { M.var (Ast.UserName $1)  |> locatm ( makel $startpos($1) $endpos($1)) }
| mutabl LEFT_BRACKET exprs RIGHT_BRACKET { M.array $1 $3  |> locatm ( makel $startpos($1) $endpos($4)) }
| mutabl DOT IDENT { M.fix (M.Dot ($1, $3)) |> locatm ( makel $startpos($1) $endpos($3))  }
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
(*
alloc_record :
| DEF IDENT SET RECORD affect_field* END
    { I.alloc_record $2 (T.auto ()  |> locatt  ( makel $startpos($1) $endpos($2)) ) $5 }
| DEF typ IDENT SET RECORD affect_field* END
    { I.alloc_record $3 $2 $6 }
;
*)
typed_varnames :
| IDENT RIGHT_PARENS { [(T.auto () |> locatt  ( makel $startpos($1) $endpos($1))), $1] }
| IDENT COMMA typed_varnames { ((T.auto () |> locatt  ( makel $startpos($1) $endpos($1))), $1) :: $3 }
;


define_var :
| DEF IDENT SET expr { I.declare (Ast.UserName $2) (T.auto () |> locatt  ( makel $startpos($1) $endpos($2)) ) $4 I.default_declaration_option }
| DEF USELESS IDENT SET expr { I.declare (Ast.UserName $3) (T.auto () |> locatt  ( makel $startpos($1) $endpos($3)) ) $5 I.useless_declaration_option }
| DEF typ IDENT SET expr { I.declare (Ast.UserName $3) $2 $5 I.default_declaration_option }
| DEF USELESS typ IDENT SET expr { I.declare (Ast.UserName $4) $3 $6 I.useless_declaration_option }
| DEF IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
  { I.alloc_array_lambda (Ast.UserName $2) (T.auto () |> locatt  (makel $startpos($1) $endpos($2))) $4 (Ast.UserName $7) $9 I.default_declaration_option }
| DEF typ IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
  { match T.unfix $2 with
  | T.Array x -> I.alloc_array_lambda (Ast.UserName $3) x $5 (Ast.UserName $8) $10 I.default_declaration_option
  | T.Auto -> I.alloc_array_lambda (Ast.UserName $3) $2 $5 (Ast.UserName $8) $10 I.default_declaration_option
  | _ -> failwith "expected array"
  }
| DEF USELESS typ IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
  { match T.unfix $3 with
  | T.Array x -> I.alloc_array_lambda (Ast.UserName $4) x $6  (Ast.UserName $9) $11 I.useless_declaration_option
  | T.Auto -> I.alloc_array_lambda (Ast.UserName $4) $3 $6 (Ast.UserName $9) $11 I.useless_declaration_option
  | _ -> failwith "expected array"
  }
| DEF READ IDENT { I.readdecl (T.auto () |> locatt  ( makel $startpos($1) $endpos($2))) (Ast.UserName $3) I.default_declaration_option }
| DEF READ typ IDENT { I.readdecl $3 (Ast.UserName $4) I.default_declaration_option }
| DEF USELESS READ IDENT { I.readdecl (T.auto () |> locatt  ( makel $startpos($1) $endpos($3))) (Ast.UserName $4) I.useless_declaration_option }
| DEF USELESS READ typ IDENT { I.readdecl $4 (Ast.UserName $5) I.useless_declaration_option }
| DEF USELESS LEFT_PARENS typed_varnames SET expr { I.untuple (List.map (fun (t, n) -> t, Ast.UserName n) $4) $6 I.useless_declaration_option }
| DEF LEFT_PARENS typed_varnames SET expr { I.untuple (List.map (fun (t, n) -> t, Ast.UserName n) $3) $5 I.default_declaration_option }
| DEF USELESS IDENT LEFT_BRACKET expr RIGHT_BRACKET WITH IDENT DO instrs END
  { I.alloc_array_lambda (Ast.UserName $3) (T.auto () |> locatt  ( makel $startpos($2) $endpos($3))) $5 (Ast.UserName $8) $10  I.useless_declaration_option}
;

cond :
| expr THEN instrs ELSE instrs END { I.if_ $1 $3 $5 }
| expr THEN instrs END { I.if_ $1 $3 [] }
| expr THEN instrs ELSIF cond { I.if_ $1 $3 [$5] }
;

control_flow :
| IF cond { $2 }
| FOR IDENT SET expr TO expr DO instrs END { I.loop (Ast.UserName $2) $4 $6 $8 }
| WHILE expr DO instrs END { I.while_ $2 $4 }
| RETURN expr { I.return $2 }
| IDENT LEFT_PARENS exprs RIGHT_PARENS { I.call $1 $3 }
;

instr :
| TAG IDENT { I.tag $2 |> locati ( makel $startpos($1) $endpos($2)) }
| UNQUOTE_START expr END_QUOTE { I.unquote $2 |> locati ( makel $startpos($1) $endpos($3))}
| COMMENT { I.comment $1 }
| define_var { $1 |> locati ( makel $startpos($1) $endpos($1))}
| control_flow { $1 |> locati ( makel $startpos($1) $endpos($1)) }
| mutabl SET expr { I.affect $1 $3 |> locati ( makel $startpos($1) $endpos($3)) }
| mutabl ADDON expr { I.affect $1
                      (E.add (E.access $1
                                 |> locate ( makel $startpos($1) $endpos($1))
                       ) $3 |> locate ( makel $startpos($1) $endpos($3))
                      )
                      |> locati ( makel $startpos($1) $endpos($3))
}
| mutabl SUBON expr { I.affect $1
                      (E.sub (E.access $1
                                 |> locate ( makel $startpos($1) $endpos($1))
                       ) $3 |> locate ( makel $startpos($1) $endpos($3))
                      )
                      |> locati ( makel $startpos($1) $endpos($3))
}
| mutabl DIVON expr { I.affect $1
                      (E.div (E.access $1
                                 |> locate ( makel $startpos($1) $endpos($1))
                       ) $3 |> locate ( makel $startpos($1) $endpos($3))
                      )
                      |> locati ( makel $startpos($1) $endpos($3))
}
| mutabl MULON expr { I.affect $1
                      (E.mul (E.access $1 |> locate ( makel $startpos($1) $endpos($1))
                       ) $3 |> locate ( makel $startpos($1) $endpos($3)))
                      |> locati ( makel $startpos($1) $endpos($3))
}
| mutabl INCR { I.affect $1
                      (E.add (E.access $1
                                 |> locate ( makel $startpos($1) $endpos($1))
                       ) (E.integer 1 |> locate ( makel $startpos($2) $endpos($2))))
                      |> locati ( makel $startpos($1) $endpos($2))
}
| mutabl DECR { I.affect $1
                      (E.sub (E.access $1
                                 |> locate ( makel $startpos($1) $endpos($1))
                       ) (E.integer 1 |> locate ( makel $startpos($2) $endpos($2)))
                      )
                      |> locati ( makel $startpos($1) $endpos($2))
}
| READ typ mutabl { I.read $2 $3 |> locati ( makel $startpos($1) $endpos($3)) }
| PRINT expr { I.print (T.auto () |> locatt  ( makel $startpos($1) $endpos($1))) $2 |> locati ( makel $startpos($1) $endpos($2)) }
| PRINT typ expr { I.print $2 $3 |> locati ( makel $startpos($1) $endpos($3)) }
| SKIP { I.stdin_sep () |> locati ( makel $startpos($1) $endpos($1)) }
(*| alloc_record { $1 |> locati ( makel $startpos($1) $endpos($1)) }
*);

instrs :
| { [] }
| instr PERIOD? instrs { $1 :: $3 }
;
arg :
| typ IDENT { Ast.UserName $2, $1 }
;

args :
| { [] }
| arg { [$1] }
| arg COMMA args { $1 :: $3 }
;

arg_macro :
| typ IDENT { $2, $1 }
;

args_macro :
| { [] }
| arg_macro { [$1] }
| arg_macro COMMA args_macro { $1 :: $3 }
;

define :
| UNQUOTE_START expr END_QUOTE { P.unquote $2 }
| COMMENT { P.comment $1 }
| DEF USELESS typ IDENT LEFT_PARENS args RIGHT_PARENS instrs END { P.declarefun $4 $3 $6 $8 P.useless_declaration_option }
| DEF typ IDENT LEFT_PARENS args RIGHT_PARENS instrs END { P.declarefun $3 $2 $5 $7 P.default_declaration_option }
| MACRO typ IDENT LEFT_PARENS args_macro RIGHT_PARENS macro* END { P.macro $3 $2 $5 $7 }
| RECORD AT IDENT decl_field* END { P.DeclareType ($3, (T.struct_ $4 )) }
| ENUM AT IDENT ENUM_FIELD* END { P.DeclareType ($3, T.enum $4 ) }
| TAG IDENT define { Tags.tag_topLVL $2; $3 }
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
