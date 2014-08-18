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

let min2 =
  (fun a b ->
      let m = (fun () -> ()) in
      (if (a < b)
       then a
       else b));;
let min3 =
  (fun a b c ->
      (min2 (min2 a b) c));;
let min4 =
  (fun a b c d ->
      (min3 (min2 a b) c d));;
let rec pathfind_aux =
  (fun cache tab x y posX posY ->
      let g = (fun () -> ()) in
      (if ((posX = (x - 1)) && (posY = (y - 1)))
       then 0
       else let h = (fun () -> (g ())) in
       (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
        then ((x * y) * 10)
        else let k = (fun () -> (h ())) in
        (if (tab.(posY).(posX) = '#')
         then ((x * y) * 10)
         else let l = (fun () -> (k ())) in
         (if (cache.(posY).(posX) <> (- 1))
          then cache.(posY).(posX)
          else (
                 cache.(posY).(posX) <- ((x * y) * 10);
                 let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
                 let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
                 let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
                 let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
                 let out_ = (1 + (min4 val1 val2 val3 val4)) in
                 (
                   cache.(posY).(posX) <- out_;
                   out_
                   )
                 
                 )
          )))));;
let pathfind =
  (fun tab x y ->
      let cache = (Array.init_withenv y (fun i ->
                                            (fun () -> let tmp = (Array.init_withenv x (fun
                                             j ->
                                            (fun () -> let f = (- 1) in
                                            ((), f))) ()) in
                                            let e = tmp in
                                            ((), e))) ()) in
      (pathfind_aux cache tab x y 0 0));;
let main =
  let x = 0 in
  let y = 0 in
  Scanf.scanf "%d"
  (fun r ->
      let x = r in
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun q ->
          let y = q in
          (Scanf.scanf "%[\n \010]" (fun _ -> let tab = (Array.init_withenv y (fun
           i ->
          (fun () -> let tab2 = (Array.init_withenv x (fun j ->
                                                          (fun () -> let tmp = '\000' in
                                                          Scanf.scanf "%c"
                                                          (fun p ->
                                                              let tmp = p in
                                                              let o = tmp in
                                                              ((), o)))) ()) in
          (Scanf.scanf "%[\n \010]" (fun _ -> let n = tab2 in
          ((), n))))) ()) in
          let result = (pathfind tab x y) in
          (Printf.printf "%d" result)))))));;

