open Parser
let rec string_of_lexem f = function
  | COMMENT c -> Format.fprintf f "/* %s */ " c
  | MAIN -> Format.fprintf f "main "
  | IF -> Format.fprintf f "if "
  | THEN -> Format.fprintf f "then "
  | ELSE -> Format.fprintf f "else "
  | ELSIF -> Format.fprintf f "elsif "
  | END -> Format.fprintf f "end "
  | DO -> Format.fprintf f "do "
  | FOR -> Format.fprintf f "for "
  | TO -> Format.fprintf f "to "
  | WHILE -> Format.fprintf f "while "
  | RETURN -> Format.fprintf f "return "
  | DEF -> Format.fprintf f "def "
  | MACRO -> Format.fprintf f "macro "
  | WITH -> Format.fprintf f "with "
  | READ -> Format.fprintf f "read "
  | PRINT -> Format.fprintf f "print "
  | SKIP -> Format.fprintf f "skip "
  | ENUM -> Format.fprintf f "enum "
  | RECORD -> Format.fprintf f "record "
  | SET -> Format.fprintf f "= "
  | DOT -> Format.fprintf f ". "
  | COMMA -> Format.fprintf f ", "
  | PERIOD -> Format.fprintf f "; "
  | COLON -> Format.fprintf f ": "
  | AT -> Format.fprintf f "@ "
  | LEFT_PARENS -> Format.fprintf f "( "
  | RIGHT_PARENS -> Format.fprintf f ") "
  | LEFT_BRACKET -> Format.fprintf f "[ "
  | RIGHT_BRACKET -> Format.fprintf f "] "
  | NOT -> Format.fprintf f "! "
  | AND -> Format.fprintf f "&& "
  | OR -> Format.fprintf f "|| "
  | EQUAL -> Format.fprintf f "== "
  | NOT_EQUAL -> Format.fprintf f "!= "
  | LOWER -> Format.fprintf f "< "
  | HIGHER -> Format.fprintf f "> "
  | LOWER_OR_EQUAL -> Format.fprintf f "<= "
  | HIGHER_OR_EQUAL -> Format.fprintf f ">= "
  | ADD -> Format.fprintf f "+ "
  | NEG -> Format.fprintf f "- "
  | MUL -> Format.fprintf f "* "
  | DIV -> Format.fprintf f "/ "
	| ADDON -> Format.fprintf f "+= "
	| SUBON -> Format.fprintf f "-= "
	| DIVON -> Format.fprintf f "/= "
	| MULON -> Format.fprintf f "*= "
	| INCR -> Format.fprintf f "++ "
	| DECR -> Format.fprintf f "-- "
  | MODULO -> Format.fprintf f "%% "
  | TYPE_INT -> Format.fprintf f "int "
  | TYPE_AUTO -> Format.fprintf f "auto "
  | TYPE_STRING -> Format.fprintf f "string "
  | TYPE_FLOAT -> Format.fprintf f "float "
  | TYPE_CHAR -> Format.fprintf f "char "
  | TYPE_BOOL -> Format.fprintf f "bool "
  | TYPE_ARRAY -> Format.fprintf f "array "
  | TYPE_VOID -> Format.fprintf f "void "
  | TYPE_LEXEMS -> Format.fprintf f "lexems "
  | TRUE -> Format.fprintf f "true "
  | FALSE -> Format.fprintf f "false "
  | INT i -> Format.fprintf f "%d " i
  | CHAR c -> Format.fprintf f "%C " c
  | STRING s -> Format.fprintf f "%S " s
  | ENUM_FIELD fl -> Format.fprintf f "%s " fl
  | IDENT i -> Format.fprintf f "%s " i
  | LEXEMS li -> lexems f li
  | UNQUOTE_START -> Format.fprintf f "${ "
  | EOF -> Format.fprintf f "ENF_OF_FILE"
  | END_QUOTE -> Format.fprintf f "} "
  | TAG ->  Format.fprintf f "tag "
and lexems f (li : (Parser.token, Parser.token Ast.Expr.t) Ast.Lexems.t list )  =
  let rec h f = function
    | [] -> ()
    | hd::tl ->
      Format.fprintf f "%a %a" g hd h tl
  and g f = function
    | Ast.Lexems.Expr e -> () (* TODO *)
    | Ast.Lexems.Token t -> string_of_lexem f t
    | Ast.Lexems.UnQuote li -> Format.fprintf f "${%a}" h li
  in Format.fprintf f "{%a}" h li


let rec string_of_lexems f = function
  | [] -> ()
  | hd::tl -> Format.fprintf f "%a%a" string_of_lexem hd
    string_of_lexems tl
