
open Stdlib

let set = ref StringSet.empty

let reset () = set := StringSet.empty

let tag s = set := StringSet.add s !set
let is_taged s = StringSet.mem s !set

