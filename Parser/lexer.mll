{
	open Stdlib
	open Lexing
  let newline lexbuf =
		let p = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- { p with
      pos_lnum = 1 + p.pos_lnum ;
      pos_bol  = p.pos_cnum ;
    }

	let error lexbuf =
		let x = lexbuf.lex_curr_p in
		failwith $ Printf.sprintf "lexing error at line %i, char %i, near %s"
			x.pos_lnum
			(x.pos_cnum - x.pos_bol - 1)
			(lexeme lexbuf)

	open Parser
}

let ignore = '#' [^ '\n']*
let space = [' ' '\t' '\r']

let int = ['0'-'9']+
let char = "\\'" | [^'\'' '\\'] | "\\n" | "\\r" | ("\\" int)
let string = (( "\\\"" | [^'"'] )*)
let comment = ([^'*'] | ('*' [^'/'] ) )*
let ident = ['a'-'z'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

let enum_field = ['A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
(* whitespace *)
| "/*" (comment as str ) "*/" {
(*	token lexbuf *)
  let () = String.fold_left (fun () c ->
    if c == '\n' then
      newline lexbuf) () str in
  COMMENT(str)
}
| "{"
    {
      let oripos = lexbuf.lex_curr_p in
      let rec f (li : (token, token Ast.Expr.t) Ast.Lexems.t list) =
        match token lexbuf with
				| EOF ->
				  lexbuf.lex_curr_p <- oripos;
				  error lexbuf
        | END_QUOTE -> List.rev li
        | UNQUOTE_START ->
          let li2 = Ast.Lexems.unquote (f []) in
          f ( li2 :: li )
        | t -> f ((Ast.Lexems.token t) :: li)
      in let li = f []

         in LEXEMS li
    }
| "tag" { TAG }
| "${" { UNQUOTE_START }
| "}" { END_QUOTE }
| '\n' { newline lexbuf ; token lexbuf }
| ignore { token lexbuf }
| space { token lexbuf }
(* keyword *)
| "def"  { DEF }
| "with" { WITH }
| "main" { MAIN }
| "end"  { END }
| "read"  { READ }
| "print" { PRINT }
| "skip"  { SKIP }
| "macro" { MACRO }
| "inline" { USELESS }

(* control flow *)
| "if"   { IF }
| "then" { THEN }
| "else" { ELSE }
| "elsif" { ELSIF }
| "do"   { DO }
| "for"  { FOR }
| "to"   { TO }
| "while"  { WHILE }
| "return" { RETURN }

(* type *)
| "enum"   { ENUM }
| "record" { RECORD }
| "enum" { ENUM }
| "lexems"    { TYPE_LEXEMS }
| "string"    { TYPE_STRING }
| "int"    { TYPE_INT }
| "auto"    { TYPE_AUTO }
| "char"   { TYPE_CHAR }
| "bool"   { TYPE_BOOL }
| "array"  { TYPE_ARRAY }
| "option"  { TYPE_OPTION }
| "void"  { TYPE_VOID }

(* punctuation *)
| "=" { SET }
| "." { DOT }
| "," { COMMA }
| ";" { PERIOD }
| ":" { COLON }
| "(" { LEFT_PARENS }
| ")" { RIGHT_PARENS }
| "[" { LEFT_BRACKET }
| "]" { RIGHT_BRACKET }

(* operator *)
| "!"  { NOT }
| "&&" { AND }
| "||" { OR }

| "==" { EQUAL }
| "!=" | "<>" { NOT_EQUAL }
| "<"  { LOWER }
| ">"  { HIGHER }
| "<=" | "=<" { LOWER_OR_EQUAL }
| ">=" | "=>" { HIGHER_OR_EQUAL }

| "+=" { ADDON }
| "-=" { SUBON }
| "++" { INCR }
| "--" { DECR }
| "/=" { DIVON }
| "*=" { MULON }


| "+" { ADD }
| "-" { NEG }
| "*" { MUL }
| "/" { DIV }
| "%" { MODULO }
| "@" { AT }

(* value *)
| "nil"  { NIL }
| "some"  { JUST }
| "true"  { TRUE }
| "false" { FALSE }

| int as x { INT (int_of_string x) }
| '\'' char '\'' as x { CHAR (Scanf.sscanf x "%C" (fun x -> x)) }
| ('"' string '"') as x { STRING (Scanf.sscanf x "%S" (fun x -> x)) }
| ident as x { IDENT x }
| enum_field as x { ENUM_FIELD x }
| eof { EOF }
| _ { error lexbuf }
