{
  open Parser
}

let spacing = [' ' '\t' '\n']+
let ident = ['a'-'z'] ['0'-'9' 'a'-'z' 'A'-'Z']*

rule token = parse

(*    spacing { token lexbuf } *)
    spacing { SPACING }

  | ['0'-'9']+ '.' ['0'-'9']* as t { FLOAT( float_of_string t) }
  | ['0'-'9']+ as t { INT( int_of_string t) }
  | "true" { BOOL(true) }
  | "false" { BOOL(false) }
  | "+" { O_ADD }
  | "-" { O_NEG }
  | "*" { O_MUL }
  | "/" { O_DIV }
  | "%" { O_MOD }
  | "mod" { O_MOD }

  | "||" { O_OR }
  | "&&" { O_AND }

  | "or" { O_OR }
  | "and" { O_AND }
  | "not" { O_NOT }

  | "|" { O_BOR }
  | "lor" { O_BOR }
  | "&" { O_BAND }
  | "land" { O_BAND }
  | "~" { O_BNOT }
  | "lnot" { O_BNOT }
  | "<<" { O_BLSHIFT }
  | "lsl" { O_BLSHIFT }
  | ">>" { O_BRSHIFT }
  | "lsr" { O_BRSHIFT }

  | "==" { O_EQ }
  | "!=" { O_DIFF }

  | "!" { O_NOT }
  | "<>" { O_DIFF }


  | "[" { LBRACE }
  | "]" { RBRACE }
  | "{" { LHOOK }
  | "}" { RHOOK }
  | "(" { LPARENT }
  | ")" { RPARENT }
  | "%" (ident as b) { VARNAME(b)}


  | eof{ EOF }
