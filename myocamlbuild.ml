open Ocamlbuild_plugin;;
dispatch begin function
  | After_rules ->
    ocaml_lib "Stdlib/stdlib";
    ocaml_lib "Astutils/astutils";
  | _ -> ()
end

