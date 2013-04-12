open Ocamlbuild_plugin;;
dispatch begin function
  | After_rules ->
    ocaml_lib "Stdlib/stdlib";
    ocaml_lib "Parser/parser";
    ocaml_lib "Astutils/astutils";
    ocaml_lib "Eval/eval";
    ocaml_lib "Printers/printers";
  | After_options ->
    Options.ocamldoc := S[A"ocamldoc"; A"-keep-code";
                          A"-colorize-code";]
  | _ -> ()
end

