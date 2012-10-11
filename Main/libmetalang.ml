open Stdlib
open Ast

(** {2 Languages definition } *)


let typed f (a, b) = (a, f b)

let default_passes (prog : Parser.token Prog.t) : Parser.token Prog.t =
  prog
  |> Typer.process |> snd
  |> Passes.WalkCheckNaming.apply
  |> Passes.WalkRename.apply
  |> Passes.WalkNopend.apply
  |> Passes.WalkExpandPrint.apply

let clike_passes prog =
  prog |> default_passes
  |> Typer.process
  |> typed Passes.WalkAllocArrayExpend.apply
  |> typed Passes.WalkExpandReadDecl.apply

let ocaml_passes prog =
  prog |> default_passes
  |> Passes.WalkIfMerge.apply
  |> Typer.process

let no_passes prog =
  prog
  |> Typer.process

module L = StringMap
let languages, printers =
  let ( => )
      (pa : Parser.token Prog.t -> Typer.env * Parser.token Prog.t )
      pr
      (out: Format.formatter)
      (prog : Parser.token Prog.t) :
      (((Format.formatter -> unit) ->  unit)) -> unit
    =
    (fun (err : ((Format.formatter -> unit) -> unit)) ->
      try
        let typerEnv, processed  =
          pa prog
        in
        begin
          pr#setTyperEnv typerEnv;
          pr#prog out processed
        end
      with Warner.Error e ->
        err e
    )
  in
  let ls = [
    "c",    clike_passes => new CPrinter.cPrinter ;
    "pas",  clike_passes => new PasPrinter.pasPrinter ;
    "cc",   clike_passes => new CppPrinter.cppPrinter ;
    "cs",   clike_passes => new CsharpPrinter.csharpPrinter ;
    "java", clike_passes => new JavaPrinter.javaPrinter ;
    "ml",   ocaml_passes => new OcamlPrinter.camlPrinter ;
    "php",  clike_passes => new PhpPrinter.phpPrinter ;
    "rb",   clike_passes => new RbPrinter.rbPrinter ;
    "py",   clike_passes => new PyPrinter.pyPrinter ;
    "tex",  no_passes   =>  new TexPrinter.texPrinter ;
(*    "sch",  ocaml_passes   =>  SchemePrinter.printer ;*)

    "metalang", no_passes => new Printer.printer ;
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

let stdlib_file = "Stdlib/stdlib.metalang"

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
    let tok = Lexing.lexeme lexbuf in
    Format.fprintf f "%s: error line %d char %d on token %s\n"
      filename line cnum tok ;
  ))

let parse_file parse filename =
  let lexbuf = Lexing.from_channel (open_in filename) in
  try parse Lexer.token lexbuf
  with Parser.Error -> warn_error_of_parse_error filename lexbuf

let parse_string parse str =
  let lexbuf = Lexing.from_string str in
  try parse Lexer.token lexbuf
  with Parser.Error -> warn_error_of_parse_error "string" lexbuf

let make_prog_helper (funs, main) stdlib =
  let progname = "js_magic" in
  let stdlib = parse_string Parser.toplvls stdlib in
  let prog = {
    Prog.progname = progname ;
    Prog.funs = funs ;
    Prog.main = main ;
  } in
  let used_functions = Passes.WalkCollectCalls.fold prog in
  let go f (li, used_functions) = match f with
    | Prog.DeclarFun (v, _,_, _)
    | Prog.Macro (v, _, _, _) ->
      if BindingSet.mem v used_functions
      then (f::li, (Passes.WalkCollectCalls.fold_fun used_functions f) )
      else (li, used_functions)
    | _ -> failwith ("bad stdlib") in
  let funs_add, _ = List.fold_right go stdlib ([], used_functions) in
  let funs = funs_add @ funs in
  { prog with Prog.funs = funs }


let make_prog stdlib filename =
  let progname = Filename.chop_extension $ Filename.basename filename in
  let funs, main = parse_file Parser.prog filename in
  let stdlib = if stdlib then parse_file Parser.toplvls stdlib_file else [] in
  let prog = {
    Prog.progname = progname ;
    Prog.funs = funs ;
    Prog.main = main ;
  } in
  let used_functions = Passes.WalkCollectCalls.fold prog in
  let go f (li, used_functions) = match f with
    | Prog.DeclarFun (v, _,_, _)
    | Prog.Macro (v, _, _, _) ->
      if BindingSet.mem v used_functions
      then (f::li, (Passes.WalkCollectCalls.fold_fun used_functions f) )
      else (li, used_functions)
    | _ -> failwith ("bad stdlib") in
  let funs_add, _ = List.fold_right go stdlib ([], used_functions) in
  let funs = funs_add @ funs in
  { prog with Prog.funs = funs }

let process err c filename =
  try
    let prog = make_prog c.stdlib filename in
    if c.eval then
      let env, prog = Typer.process prog in begin
        Eval.eval_prog env prog;
        ()
      end
    else
      let go lang =
        let printer = L.find lang printers in
        let output = c.output_dir ^ "/" ^ prog.Prog.progname ^ "." ^ lang in
        if not c.quiet then Printf.printf "Generating %s\n%!" output ;
        Fresh.fresh_init prog ;
        let chan = open_out output in
        let buf = Format.formatter_of_out_channel chan in
        Format.fprintf buf "%a@;%!" (fun f () -> printer f prog err) ();
        close_out chan in
      begin  (* noms à renommer automatiquement *)
        Passes.Rename.clear ();
        Passes.Rename.add prog.Prog.progname ;
        Passes.Rename.add "out" ;
        Passes.Rename.add "exp" ;
        Passes.Rename.add "min" ;
        Passes.Rename.add "max" ;
        Passes.Rename.add "eval" ;
        List.iter go c.languages
      end
  with Warner.Error e ->
    err e

let process_config err c =
  List.iter (process err c) c.filenames

let test_process err (lang:string) txt stdlib =
  let progress = ref "" in
  let log txt = progress := !progress ^ "\n  " ^ txt in
  try
    log "starting" ;
    let lexbuf = Lexing.from_string txt in
    log "lexbuf" ;
    let prog' =
      try
        Parser.prog Lexer.token lexbuf
      with Parser.Error -> warn_error_of_parse_error "metalang" lexbuf
    in
    log "prog'" ;
    let prog = make_prog_helper prog' stdlib in
    log "prog" ;
    let printer = L.find lang printers in
    log "printer" ;
    Fresh.fresh_init prog ;
    log "fresh_init" ;
    let buf = Format.stdbuf in
    log "buf" ;
    Format.flush_str_formatter () ;
    log "flush" ;
    Format.fprintf Format.str_formatter "%a@;%!"
      (fun f () -> printer f prog err) ();
    log "fprintf" ;
    let txt = Buffer.contents buf in
    log "txt" ;
    txt
  with Warner.Error e ->
    let () = err e in ""



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
    let prog = make_prog_helper prog' stdlib in
    let env, prog = Typer.process prog in
    EVString.eval_prog env prog
  with Warner.Error e ->
    err e
