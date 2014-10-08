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

let main =
  let i = 1 in
  let last = (Array.init_withenv 5 (fun  j i -> Scanf.scanf "%c"
  (fun  c -> let d = ((int_of_char (c)) - (int_of_char ('0'))) in
  let i = (i * d) in
  let h = d in
  (i, h))) i) in
  let max0 = i in
  let index = 0 in
  let nskipdiv = 0 in
  let m = 1 in
  let n = 995 in
  let rec l k i index max0 nskipdiv =
    (if (k <= n)
     then Scanf.scanf "%c"
     (fun  e -> let f = ((int_of_char (e)) - (int_of_char ('0'))) in
     ((fun  (i, nskipdiv) -> (
                               last.(index) <- f;
                               let index = ((index + 1) mod 5) in
                               let max0 = ((max (max0) (i))) in
                               (l (k + 1) i index max0 nskipdiv)
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
            (Printf.printf "%d\n" max0)
            )
     ) in
    (l m i index max0 nskipdiv)

