open Stdlib

type varname = string

let next =
  let r = ref 0 in
  fun () ->
    let out = !r in
    begin
     r := (out + 1);
      out
    end

