{
  open Parser
}

let spacing = [' ' '\t' '\r']+
let newline = [ '\n' ]
let ident = ['a'-'z'] ['0'-'9' 'a'-'z' 'A'-'Z' '_']*
let commentignore = '#' [^'\n']*

let char = ('\\' '\'') | [^'\'' '\\']

let string = (( "\\\"" | [^'"'] )*)

rule token = parse
    commentignore { token lexbuf }
  | newline {
    let pos = lexbuf.Lexing.lex_curr_p in 
    lexbuf.Lexing.lex_curr_p <- { pos with
      Lexing.pos_lnum = pos.Lexing.pos_lnum +1;
      Lexing.pos_bol = pos.Lexing.pos_cnum;
    };
token lexbuf
  }
| spacing { token lexbuf }
(*    spacing { SPACING } *)
| '\'' (char as str) '\'' { CHAR( String.get str 0 ) }
| '"' (string as str) '"' { STRING(str) }
| "print" { PRINT }
| "read" { READ }
| "prog" { PROG }
| "if" { IF }
| "else" { ELSE }
| "var" { DECLAREVAR }
| "function" { FUNCTION }
| "return" { RETURN }
| "for" { FOR }
| "to" { TO }
| "step" { STEP }
| "dim" { DIM }
| "," { COMMA }
| ";" { DOTCOMMA }
| ":=" { AFFECT }
| "->" { ARROW }
| "bool" { TYPE( Type.bool ) }
| "integer" { TYPE( Type.integer ) }
| "char" { TYPE(Type.char) }
| "void" { TYPE( Type.void ) }
| "float" { TYPE( Type.float ) }

| "string" { TYPE( Type.string ) }
| "array" { ARRAY }
| "stdin_sep();" { STDINSEP }
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

  | ">" { O_HIGHER }
  | ">=" { O_HIGHEREQ }
  | "<" { O_LOWER }
  | "<=" { O_LOWEREQ }

  | "[" { LBRACE }
  | "]" { RBRACE }
  | "{" { LHOOK }
  | "}" { RHOOK }
  | "(" { LPARENT }
  | ")" { RPARENT }
  | "%" (ident as b) { VARNAME(b) }
  | (ident as b) { NAME(b) }
  | eof{ EOF }
  | _ {failwith ("lexing error at line " ^
		    (string_of_int lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum)
		 ^ " char : "^
		   (string_of_int
		      (lexbuf.Lexing.lex_curr_p.Lexing.pos_cnum - lexbuf.Lexing.lex_curr_p.Lexing.pos_bol - 1))
		 ^" near : " ^(Lexing.lexeme lexbuf) ) }
