{

(*
* Copyright (c) 2012, Prologin
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the University of California, Berkeley nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* @see http://prologin.org
* @author Prologin <info@prologin.org>
* @author Maxime Audouin <coucou747@gmail.com>
*
*)



  open Parser
}

let spacing = [' ' '\t' '\r']+
let newline = [ '\n' ]
let ident = ['a'-'z'] ['0'-'9' 'a'-'z' 'A'-'Z' '_']*
let commentignore = '#' [^'\n']*

  let comment = ([^'*'] | ('*' [^'/'] ) )*


let char = "\\'" | [^'\'' '\\'] | "\\0" | "\\n" | "\\r"

let string = (( "\\\"" | [^'"'] )*)

rule token = parse
  | "/*" (comment as str ) "*/" { COMMENT(str) }
  |  commentignore { token lexbuf }
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
| "return" { RETURN }
| "for" { FOR }
| "while" { WHILE }
| "macro" { MACRO }
| "to" { TO }
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
  | (ident as b) { NAME(b) }
  | eof{ EOF }
  | _ {failwith ("lexing error at line " ^
		    (string_of_int lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum)
		 ^ " char : "^
		   (string_of_int
		      (lexbuf.Lexing.lex_curr_p.Lexing.pos_cnum - lexbuf.Lexing.lex_curr_p.Lexing.pos_bol - 1))
		 ^" near : " ^(Lexing.lexeme lexbuf) ) }
