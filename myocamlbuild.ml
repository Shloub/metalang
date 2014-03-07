open Ocamlbuild_plugin;;
open Unix

let version =
  Ocamlbuild_pack.My_unix.run_and_open
    "(git describe --always --dirty || echo 'exported')" (fun ic ->
      input_line ic);;

let time =
  let tm = Unix.gmtime (Unix.time ()) in
  Printf.sprintf "%02d/%02d/%04d %02d:%02d:%02d UTC"
    (tm.tm_mon + 1) tm.tm_mday (tm.tm_year + 1900)
    tm.tm_hour tm.tm_min tm.tm_sec

let make_version _ _ =
  let cmd =
    Printf.sprintf "let version = %S
let compile_time = %S"
      version time
  in
  Cmd (S [ A "echo"; Quote (Sh cmd); Sh ">"; P "version.ml" ]);;


dispatch begin function
  | After_rules ->
    rule "version.ml" ~prod: "version.ml" make_version;
    ocaml_lib "Stdlib/stdlib";
    ocaml_lib "Parser/parser";
    ocaml_lib "Astutils/astutils";
    ocaml_lib "Passes/passes";
    ocaml_lib "Eval/eval";
    ocaml_lib "Printers/printers";
    dep ["ocaml"; "doc"] & ["docintro.txt"];
  | After_options ->
    Options.ocamldoc := S[A"ocamldoc";
                          A"-html";
                          A"-stars";
                          A"-intro"; A"docintro.txt";
                          A"-all-params";
                          A"-colorize-code";
                          A"-t"; A"Metalang"]
  | _ -> ()
end

