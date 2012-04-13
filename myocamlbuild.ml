open Ocamlbuild_plugin;;
dispatch begin function
  | After_rules ->
    ocaml_lib "Stdlib/stdlib";
    ocaml_lib "Parser/parser";
    ocaml_lib "Astutils/astutils";
    ocaml_lib "Printers/printers";
  | _ -> ()
end

