open Ocamlbuild_plugin;;
dispatch begin function
  | After_rules ->
    ocaml_lib "Stdlib/stdlib";
    ocaml_lib "Parser/parser";
    ocaml_lib "Astutils/astutils";
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

