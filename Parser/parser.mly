%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <char> CHAR
%token <bool> BOOL
%token <string> NAME

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
%token COMMENT
%token FOR
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


%start main result
%type <Prog.t_fun list * Instr.t list> main
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

instruction:
| NAME AFFECT result DOTCOMMA { Instr.affect (Instr.mutable_var $1) $3 }
| NAME arrayaccess AFFECT result DOTCOMMA
    {
      Instr.affect (Instr.mutable_array $1 $2) $4
    }
| RETURN result DOTCOMMA { Instr.return $2 }
| type NAME LBRACE result RBRACE DOTCOMMA
{
match $1 with
  | Type.F (Type.Array t) ->
    Instr.alloc_array $2 t $4
  (* TODO *)
}
| NAME LPARENT RPARENT DOTCOMMA { Instr.call $1 [] }
| NAME LPARENT params RPARENT DOTCOMMA { Instr.call $1 $3 }
| type NAME AFFECT result DOTCOMMA { Instr.declare $2 $1 $4 }
| IF LPARENT result RPARENT LHOOK instructions RHOOK ELSE LHOOK instructions RHOOK { Instr.if_ $3 $6 $10 }
| IF LPARENT result RPARENT LHOOK instructions RHOOK { Instr.if_ $3 $6 [] }
| PRINT O_LOWER type O_HIGHER LPARENT result RPARENT DOTCOMMA {
      Instr.print $3 $6
    }
| READ O_LOWER type O_HIGHER LPARENT NAME RPARENT DOTCOMMA {
      Instr.read $3 $6
    }
| FOR NAME AFFECT result TO result LHOOK instructions RHOOK
{ Instr.loop $2 $4 $6 $8 }
| STDINSEP { Instr.stdin_sep }

instructions:
| instruction { [$1] }
| instruction instructions { $1::$2 }
;

param_list:
| type NAME { [($2, $1)] }
| type NAME COMMA param_list { ($2, $1) :: $4 }

bloc:
    | LHOOK instructions RHOOK { $2 } ;
    | LHOOK RHOOK { [] } ;

main_prog:
  PROG bloc { $2 } ;

function_:
    | type NAME LPARENT param_list RPARENT bloc {
      Prog.declarefun $2 $1 $4 $6 }
    | type NAME LPARENT RPARENT bloc {
      Prog.declarefun $2 $1 [] $5 } ;

functions:
    | function_ { [$1] }
    | function_ functions { $1::$2 };

prog:
    | functions main_prog { ( $1, $2) }
    | main_prog { ([], $1) }
;

main:
  prog eof { $1 }
;
