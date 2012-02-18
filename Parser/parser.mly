%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <bool> BOOL
%token <string> VARNAME

%token SPACING
%token LBRACE
%token RBRACE
%token LHOOK
%token RHOOK
%token LPARENT
%token RPARENT

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

%start main
%type <Expr.t> main
%%

eof : EOF { () } ;

int :
  INT { Expr.integer $1 }

result :

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
| VARNAME { Expr.binding $1 }
| SPACING result { $2 }
| result SPACING { $1 }
main:
  result eof { $1 }
;
