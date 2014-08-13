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

let rec max2 =
  (fun a b ->
      let h = (fun a b ->
                  ()) in
      (if (a > b)
       then a
       else b));;
let rec main =
  let i = 1 in
  let g = 5 in
  let last = (Array.init_withenv g (fun j ->
                                       (fun (g, i) ->
                                           Scanf.scanf "%c"
                                           (fun c ->
                                               let d = ((int_of_char (c)) - (int_of_char ('0'))) in
                                               let i = (i * d) in
                                               let l = d in
                                               ((g, i), l)))) (g, i)) in
  let max_ = i in
  let index = 0 in
  let nskipdiv = 0 in
  let p = 1 in
  let q = 995 in
  let rec m k nskipdiv index max_ g i =
    (if (k <= q)
     then Scanf.scanf "%c"
     (fun e ->
         let f = ((int_of_char (e)) - (int_of_char ('0'))) in
         let n = (fun f e nskipdiv index max_ g i ->
                     (last.(index) <- f; let index = ((index + 1) mod 5) in
                     let max_ = (max2 max_ i) in
                     (m (k + 1) nskipdiv index max_ g i))) in
         (if (f = 0)
          then let i = 1 in
          let nskipdiv = 4 in
          (n f e nskipdiv index max_ g i)
          else let i = (i * f) in
          let o = (fun f e nskipdiv index max_ g i ->
                      let nskipdiv = (nskipdiv - 1) in
                      (n f e nskipdiv index max_ g i)) in
          (if (nskipdiv < 0)
           then let i = (i / last.(index)) in
           (o f e nskipdiv index max_ g i)
           else (o f e nskipdiv index max_ g i))))
     else begin
            (Printf.printf "%d" max_);
            (Printf.printf "%s" "\n")
            end
     ) in
    (m p nskipdiv index max_ g i);;

