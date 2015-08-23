module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    let tab = Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    ) in !refenv, tab
end

let id b =
  b
let g t index =
  t.(index) <- false
let main =
  let j = 0 in
  (fun (j, a) ->( Printf.printf "%d " j;
                  if a.(0)
                  then Printf.printf "%s" "True"
                  else Printf.printf "%s" "False";
                  Printf.printf "%s" "\n";
                  g (id a) 0;
                  if a.(0)
                  then Printf.printf "%s" "True"
                  else Printf.printf "%s" "False";
                  Printf.printf "%s" "\n")) (Array.init_withenv 5 (fun i j -> ( Printf.printf "%d" i;
                                                                                let j = j + i in
                                                                                let c = i mod 2 = 0 in
                                                                                j, c)) j)

