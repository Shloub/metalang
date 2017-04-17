type foo = {
  mutable a : int;
  mutable b : int option;
  mutable c : int array option;
  mutable d : int option array;
  mutable e : int array;
  mutable f : foo option;
  mutable g : foo option array;
  mutable h : foo array option;
};;

let default0 _a _b _c _d _e _f =
  0

let aa _b =
  
  ()

let () =
 let _a = None in
  Printf.printf "___\n" 
 