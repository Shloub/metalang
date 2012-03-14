open Stdlib

type varname = string
type typename = string
type funname = string

module BindingSet = MakeSet (struct
  type t = string
  let compare = String.compare
end)

module BindingMap = MakeMap (struct
  type t = string
  let compare = String.compare
end)

let next =
  let r = ref 0 in
  fun () ->
    let out = !r in
    begin
     r := (out + 1);
      out
    end
