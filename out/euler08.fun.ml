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

let max2 =
  (fun a b ->
      let h = (fun () -> ()) in
      (if (a > b)
       then a
       else b));;
let main =
  let i = 1 in
  let g = 5 in
  let last = (Array.init_withenv g (fun j i ->
                                       Scanf.scanf "%c"
                                       (fun c ->
                                           let d = ((int_of_char (c)) - (int_of_char ('0'))) in
                                           let i = (i * d) in
                                           let l = d in
                                           (i, l))) i) in
  let max_ = i in
  let index = 0 in
  let nskipdiv = 0 in
  let n = 1 in
  let o = 995 in
  let rec m k i index max_ nskipdiv =
    (if (k <= o)
     then Scanf.scanf "%c"
     (fun e ->
         let f = ((int_of_char (e)) - (int_of_char ('0'))) in
         ((fun (i, nskipdiv) ->
              (
                last.(index) <- f;
                let index = ((index + 1) mod 5) in
                let max_ = (max2 max_ i) in
                (m (k + 1) i index max_ nskipdiv)
                )
              ) (if (f = 0)
                 then let i = 1 in
                 let nskipdiv = 4 in
                 (i, nskipdiv)
                 else let i = (i * f) in
                 let i = (if (nskipdiv < 0)
                          then let i = (i / last.(index)) in
                          i
                          else i) in
                 let nskipdiv = (nskipdiv - 1) in
                 (i, nskipdiv))))
     else (
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n")
            )
     ) in
    (m n i index max_ nskipdiv);;

