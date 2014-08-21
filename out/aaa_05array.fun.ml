module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let id b =
  b
let g t index =
  t.(index) <- false
let main =
  let c = 5 in
  let a = (Array.init_withenv c (fun  i () -> (
                                                (Printf.printf "%d" i);
                                                let f = ((i mod 2) = 0) in
                                                ((), f)
                                                )
  ) ()) in
  let d = a.(0) in
  (
    (if d
     then (Printf.printf "True")
     else (Printf.printf "False"));
    (Printf.printf "\n" );
    (g (id a) 0);
    let e = a.(0) in
    (
      (if e
       then (Printf.printf "True")
       else (Printf.printf "False"));
      (Printf.printf "\n" )
      )
    
    )
  

