open Stdlib
open Ast

(** Liste des mots clés à ne pas utiliser en metalang *)
let keywords lang=
  let li = [
    "abstract";"add";"alias";"as";"asm";"auto";"and";"assert";
    "base";"bool";"boolean";"break";"byte";"begin";
    "case";"catch";"char";"checked";"class";"const";"continue";"constraint";
    "decimal";"default";"delegate";"do";"double";"delete";"done";"downto";"def";"del";
    "else";"elif";"elsif";"enum";"event";"explicit";"extern";"explicit";"exp";"eval";"end";"exception";"external";"extends";"except";"ensure";
    "False";"false";"finally";"final";"fixed";"float";"for";"foreach";"friend";"from";"fun";"function";"functor";
    "get";"global";"goto";"go";
    "if";"implicit";"in";"int";"interface";"internal";"is";"inline";"init";"include";"inherit";"initializer";"implements";"import";"instanceof";
    "lock";"long";"lazy";"let";"lambda";
    "mutable";"min"; "max";"match";"method";"module";
    "namespace";"new";"null";"native";"None";"nonlocal";"not";"next"; "nil";
    "object";"operator";"out";"override";"or";"of";"open";
    "params";"partial";"private";"protected";"public";"package";"pass";
    "readonly";"ref";"remove";"return";"register";"rec";"raise";"redo";"rescue";"retry";
    "sig";"sbyte";"sealed";"set";"short";"sizeof";"stackalloc";"static";"string";"struct";"switch";"signed";"sizeof";"strictfp";"super";"synchronized";
    "this";"throw";"throws";"transient";"True";"true";"try";"typeof";"template";"typedef";"to";"then";"type";
    "uint";"ulong";"unchecked";"unsafe";"ushort";"using";"unsigned";"unless";"undef";"until";
    "value";"virtual";"void"; "volatile";"val";
    "where";"while";"when";"with";
    "yield";
  ]
  in match lang with
  | "cl" -> "isqrt" :: "t" :: "mem" :: "nth" :: "cons" :: "find" :: li
  | "php" -> "sqrt" :: "log10" :: li
  | _ -> li

let conf_rename lang prog =
  Fresh.fresh_init prog ;
  Rename.clear ();
  Rename.add prog.Prog.progname ;
  List.iter Rename.add (keywords lang)

(** {2 Languages definition } *)

let debug_printer = new PosPrinter.posPrinter
let debug_print prog = debug_printer#prog Format.std_formatter prog
let pass_debug_print (a, prog) =
  debug_printer#setTyperEnv a;
  debug_print prog;
  (a, prog)

let base_printer = new Printer.printer
let base_print prog = base_printer#prog Format.std_formatter prog
let pass_base_print (a, prog) =
  base_printer#setTyperEnv a;
  base_print prog;
  (a, prog)

let typed name f (a, b) =
  (*  debug_print b;
      let before = Passes.WalkCountNoPosition.fold () b in *)
  let b = f () b in (*
                      let after = Passes.WalkCountNoPosition.fold () b in
                      Format.fprintf Format.std_formatter "Pass : %s lost %d positions (%d missing)@\n" name (after - before) after; *)
  (a, b)

let typed_ name f (a, b) = (a, f b)

let check_reads = (fun (tyenv, prog) ->
  (if Tags.is_taged "use_readmacros" then
      let need_stdinsep = prog.Prog.hasSkip in
      let need_readint = TypeSet.mem (Type.integer) prog.Prog.reads in
      let need_readchar = TypeSet.mem (Type.char) prog.Prog.reads in
      let need = need_stdinsep || need_readint || need_readchar in
      if need then
        begin
          debug_print prog;
          raise (Warner.Error (fun f -> Format.fprintf f "Cannot use macros like read_int, read_char_line, read_int_line and skip or read.\n"))
        end );
  (tyenv, prog))

let default_passes (prog : Typer.env * Utils.prog) :
    (Typer.env * Utils.prog ) =
  prog
  |> typed "check naming" Passes.WalkCheckNaming.apply
  |> CheckUseVoid.apply
  |> typed "check return" CheckReturn.apply
  |> typed "remove tags" Passes.WalkRemoveTags.apply
  |> typed "rename" Passes.WalkRename.apply
  |> typed "expend" Passes.WalkNopend.apply
  |> typed "expend print" Passes.WalkExpandPrint.apply
  |> typed "internal tags" Passes.WalkInternalTags.apply
  |> snd |> Typer.process

let clike_passes prog =
  prog |> default_passes
  |> (fun (a, prog) ->
    let tuples, prog = DeclareTuples.apply a prog in
    let b = Passes.WalkExpandUnTuple.apply (a, tuples) prog
    in a, b)
  |> snd |> Typer.process
  |> (fun (a, b) ->
    a, Passes.WalkRecordExprToInstr.apply (Passes.WalkRecordExprToInstr.init_acc a) b)
  |> snd |> Typer.process
  |> typed "array expand" Passes.WalkAllocArrayExpend.apply
  |> typed "expand read decl" Passes.WalkExpandReadDecl.apply
  |> snd |> Typer.process
  |> typed_ "read analysis" ReadAnalysis.apply
  |> check_reads

let php_passes prog =
  prog |> default_passes
  |> (fun (a, b) ->
    a, Passes.WalkRecordExprToInstr.apply (Passes.WalkRecordExprToInstr.init_acc a) b)
  |> snd |> Typer.process
  |> typed "array expand" Passes.WalkAllocArrayExpend.apply
  |> typed "expand read decl" Passes.WalkExpandReadDecl.apply
  |> snd |> Typer.process
  |> typed_ "read analysis" ReadAnalysis.apply
  |> check_reads

let python_passes prog =
  prog |> default_passes
  |> typed "array expand" Passes.WalkAllocArrayExpend.apply
  |> typed "expand read decl" Passes.WalkExpandReadDecl.apply
  |> snd |> Typer.process
  |> typed_ "read analysis" ReadAnalysis.apply
  |> check_reads

let common_lisp_passes prog =
  prog |> default_passes
  |> (fun (a, prog) ->
    let tuples, prog = DeclareTuples.apply a prog in
    let b = Passes.WalkExpandUnTuple.apply (a, tuples) prog
    in a, b)
  |> snd |> Typer.process
  |> (fun (a, b) ->
    a, Passes.WalkRecordExprToInstr.apply (Passes.WalkRecordExprToInstr.init_acc a) b)
  |> snd |> Typer.process
  |> typed "merging if" Passes.WalkIfMerge.apply
  |> snd |> Typer.process
  |> typed_ "read analysis" ReadAnalysis.apply
  |> check_reads

let ocaml_passes prog =
  prog |> default_passes
  |> typed "merging if" Passes.WalkIfMerge.apply
  |> snd |> Typer.process
  |> typed_ "read analysis" ReadAnalysis.apply
  |> check_reads

let no_passes prog =
  prog

module L = StringMap
let languages, printers =
  let ( => )
      (pa : (Typer.env * Utils.prog) -> Typer.env * Utils.prog )
      pr
      (out: Format.formatter)
      (prog : Typer.env * Utils.prog) :
      (((Format.formatter -> unit) ->  unit)) -> unit
    =
    (fun (err : ((Format.formatter -> unit) -> unit)) ->
      let typerEnv, processed  =
        pa prog
      in
      begin
        pr#setTyperEnv typerEnv;
        pr#prog out processed
      end

    )
  in
  let ls = [
    "c",    clike_passes => new CPrinter.cPrinter ;
    "pas",  clike_passes => new PasPrinter.pasPrinter ;
    "cc",   clike_passes => new CppPrinter.cppPrinter ;
    "cs",   clike_passes => new CsharpPrinter.csharpPrinter ;
    "java", clike_passes => new JavaPrinter.javaPrinter ;
    "js",   clike_passes => new JsPrinter.jsPrinter ;
    "ml",   ocaml_passes => new OcamlPrinter.camlPrinter ;
    "php",  php_passes => new PhpPrinter.phpPrinter ;
    "rb",   python_passes => new RbPrinter.rbPrinter ;
    "py",   python_passes => new PyPrinter.pyPrinter ;
    "go",   clike_passes => new GoPrinter.goPrinter ;
    "cl",   common_lisp_passes  => new CommonLispPrinter.commonLispPrinter ;

    "metalang_parsed", no_passes => new Printer.printer ;
  (* Si on met cette passe en premier,
     on se retrouve avec les erreurs de typages avant les erreurs de naming
  *)
  ] in
  let langs : string list = List.map fst ls in
  let map = L.from_list ls
  in langs, map

let remove_unknown_languages =
  let go lang =
    L.mem lang printers
    || (Printf.fprintf stderr "unknown language %s\n" lang ; false)
  in List.filter go

let stdlib_file =
  try
    Sys.getenv "METALANG_STDLIB"
  with Not_found -> "Stdlib/stdlib.metalang"

(** {2 Command Line Arguments} *)

type config = {
  mutable languages : string list ;
  mutable output_dir : string ;
  mutable filenames : string list ;
  mutable quiet : bool;
  mutable stdlib : bool;
  mutable eval : bool;
}

let default_config () = {
  languages = languages ;
  output_dir = "." ;
  filenames = [] ;
  quiet = false ;
  stdlib = true;
  eval = false;
}

(** {2 Process} *)
let warn_error_of_parse_error filename lexbuf =
  raise (Warner.Error (fun f ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol - 1 in
    let filecontent =
      let i = open_in filename in
      let l = ref "" in
      for j = 1 to line do
        l := input_line i
      done; !l
    in
    let tok = Lexing.lexeme lexbuf in
    Format.fprintf f "file:%s@\nerror line %d char %d on token %s@\n%s@\n%s^@\n"
      filename line cnum tok filecontent (String.make cnum ' ') ;
  ))

let parse_file parse filename =
  Ast.parsed_file := filename;
  let lexbuf = Lexing.from_channel (open_in filename) in
  try parse Lexer.token lexbuf
  with
  | Parser.Error -> warn_error_of_parse_error filename lexbuf
  | Failure s -> warn_error_of_parse_error filename lexbuf

let parse_string parse str =
  Ast.parsed_file := "stdin";
  let lexbuf = Lexing.from_string str in
  try parse Lexer.token lexbuf
  with
  | Parser.Error -> warn_error_of_parse_error "string" lexbuf
  | Failure s -> warn_error_of_parse_error "string" lexbuf

let make_prog_helper progname (funs, main) stdlib =
  let prog = {
    Prog.hasSkip = false;
    Prog.reads = TypeSet.empty;
    Prog.progname = progname ;
    Prog.funs = stdlib @ funs;
    Prog.main = main ;
  } in
  (*
    debug_print prog;

    let before = Passes.WalkCountNoPosition.fold () prog in
    Format.fprintf Format.std_formatter "After parsing, %d positions missing@\n" before;
  *)
  let prog = Eval.EvalConstantes.apply prog in
  (*
    debug_print prog;
    let before = Passes.WalkCountNoPosition.fold () prog in
    Format.fprintf Format.std_formatter "After eval constantes, %d positions missing@\n" before; *)

  let tyenv, prog = Typer.process prog in
  (*
    let before = Passes.WalkCountNoPosition.fold () prog in
    Format.fprintf Format.std_formatter "After typer, %d positions missing@\n" before;
  *)
  let prog = RemoveUselessFunctions.apply prog
    (List.filter Passes.no_macro funs) in
  let prog = RemoveUselessTypes.apply prog
    prog.Prog.funs tyenv in
  tyenv, prog

(* coloration syntaxique *)
let colore string =
  try
    let lexbuf = Lexing.from_string string in
    let code, main = Parser.prog Lexer.token lexbuf in
    let prog = {
      Prog.progname = "";
      Prog.funs = code;
      Prog.main = main;
      Prog.hasSkip = false;
      Prog.reads = TypeSet.empty;
    } in
    let p = new HtmlPrinter.htmlPrinter in
    let out = Format.str_formatter in
    let () = p#prog out prog in
    Format.flush_str_formatter ()
  with Parser.Error ->
    try
      let lexbuf = Lexing.from_string string in
      let instructions = Parser.toplvl_instrs Lexer.token lexbuf in
      let p = new HtmlPrinter.htmlPrinter in
      let out = Format.str_formatter in
      let () = p#instructions out instructions in
      Format.flush_str_formatter ()
    with Parser.Error ->
      try
        let lexbuf = Lexing.from_string string in
        let instructions = Parser.toplvls Lexer.token lexbuf in
        let p = new HtmlPrinter.htmlPrinter in
        let out = Format.str_formatter in
        let () = p#proglist out instructions in
        Format.flush_str_formatter ()
      with Parser.Error -> string

(**
   this string is added at the beginning of the stdlib
   It should be used (eg in macros) to know what's the target language
*)
let stdlib_string lang = Printf.sprintf "

enum @target_language
  LANG_C
  LANG_Pas
  LANG_Cc
  LANG_Cs
  LANG_Java
  LANG_Js
  LANG_Ml
  LANG_Php
  LANG_Rb
  LANG_Py
  LANG_Go
  LANG_Cl
  LANG_Metalang_parsed
end
def @target_language current_language ()
  return LANG_%s
end

" (String.capitalize lang)

let make_prog stdlib filename lang =
  let progname = Filename.chop_extension $ Filename.basename filename in
  let funs, main = parse_file Parser.prog filename in
  let stdlib = if stdlib then parse_file Parser.toplvls stdlib_file else [] in
  let stdlib_addon = parse_string Parser.toplvls (stdlib_string lang) in
  let stdlib = List.append stdlib_addon stdlib in
  make_prog_helper progname (funs, main) stdlib

let process err c filename =
  try
    if c.eval then
      let env, prog = make_prog c.stdlib filename "metalang_parsed" in
      let _ = Eval.eval_prog env prog in ()
    else
      let go lang =
        let env, prog = make_prog c.stdlib filename lang in
        let printer = L.find lang printers in
        let output = c.output_dir ^ "/" ^ prog.Prog.progname ^ "." ^
          lang in
        try
          if not c.quiet then Printf.printf "Generating %s\n%!" output ;
          conf_rename lang prog ;
          Tags.reset ();
          let chan = open_out output in
          let buf = Format.formatter_of_out_channel chan in
          Format.fprintf buf "%a@;%!" (fun f () -> printer f (env, prog) err) ();
          close_out chan
        with Warner.Error e ->
          Unix.unlink output;
          err e
      in List.iter go c.languages
  with Warner.Error e ->
    err e

let process_config err c =
  List.iter (process err c) c.filenames

let js_make_prog_helper lang (funs, main) stdlib =
  Tags.reset ();
  let progname = "js_magic" in
  let stdlib = (stdlib_string lang) ^ stdlib in
  let stdlib = parse_string Parser.toplvls stdlib in
  make_prog_helper progname (funs, main) stdlib

let js_process err (lang:string) txt stdlib =
  try
    let lexbuf = Lexing.from_string txt in
    let prog' =
      try
        Parser.prog Lexer.token lexbuf
      with Parser.Error -> warn_error_of_parse_error "metalang" lexbuf
    in
    let tyenv, prog = js_make_prog_helper lang prog' stdlib in
    conf_rename lang prog ;
    let printer = L.find lang printers in
    Fresh.fresh_init prog ;
    let buf = Format.stdbuf in
    let _ = Format.flush_str_formatter () in
    Format.fprintf Format.str_formatter "%a@;%!"
      (fun f () -> printer f (tyenv, prog) err) ();
    let txt = Buffer.contents buf in
    txt
  with Warner.Error e ->
    let () = err e in ""

(* utilisé pour faire du javascript *)
module E = struct
  let add_str = ref (fun s -> ())
  let b = ref (Scanf.Scanning.from_string "")
  let print_int i =
    let _ = Format.flush_str_formatter () in
    let () = Format.fprintf Format.str_formatter "%d" i in
    (!add_str) (Format.flush_str_formatter ())
  let print_char c =
    let _ = Format.flush_str_formatter () in
    let () = Format.fprintf Format.str_formatter "%c" c in
    (!add_str) (Format.flush_str_formatter ())
  let print_string s = (!add_str) s
  let print_bool b =  (!add_str) ( if b then "True" else "False")

  let read_int () = Scanf.bscanf (!b) "%d" (fun x -> x)
  let read_char () = Scanf.bscanf (!b) "%c" (fun x -> x)
  let skip () = Scanf.bscanf (!b) "%[\n \010]" (fun _ -> ())

end

module EVString = Eval.EvalF(E)
let eval_string code stdlib err stdin stdout =
  let () = E.b := Scanf.Scanning.from_string stdin in
  let () = E.add_str := stdout in
  try
    let lexbuf = Lexing.from_string code in
    let prog' =
      try
        Parser.prog Lexer.token lexbuf
      with Parser.Error -> warn_error_of_parse_error "metalang" lexbuf
    in
    let env, prog = js_make_prog_helper "metalang" prog' stdlib in
    EVString.eval_prog env prog
  with Warner.Error e ->
    err e
