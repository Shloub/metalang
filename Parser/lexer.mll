{
  open Parser
}

let spacing = [' ' '\t' '\n']+

rule token = parse
    spacing { token lexbuf }
  | ['0'-'9']+ as t { INT( int_of_string t) }
  | "*" { O_MUL }
  | "/" { O_DIV }
  | "+" { O_ADD }
  | "-" { O_NEG }
  | "%" { O_MOD }
  | eof{ EOF }
