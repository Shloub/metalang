%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <bool> BOOL
%token <string> VARNAME

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

%right INT
%left O_ADD
%left O_NEG
%left O_MUL

%token EOF

%start main
%type <Expr.t> main
%%

eof : EOF { () } ;

int :
  INT { Expr.integer $1 }

result :
| result O_MUL result { Expr.mul $1 $3 }
| result O_NEG result { Expr.sub $1 $3 }
| result O_ADD result { Expr.add $1 $3 }
| LPARENT result RPARENT { $2 }
| int { $1 }

main:
  result eof { $1 }
;
