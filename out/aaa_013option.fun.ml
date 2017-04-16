type foo = {mutable a : int; mutable b : int option; mutable c : int array option; mutable d : int option array; mutable e : int array; mutable f : foo option; mutable g : foo option array; mutable h : foo array option;}

let default0 a b c d e f =
  0

let aa b =
  ()

let main =
  Printf.printf "%s" "___\n"

