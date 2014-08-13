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

let rec min2 =
  (fun a b ->
      let p = (fun a b ->
                  ()) in
      (if (a < b)
       then a
       else b));;
let rec min3 =
  (fun a b c ->
      (min2 (min2 a b) c));;
let rec min4 =
  (fun a b c d ->
      (min3 (min2 a b) c d));;
let rec read_int =
  (fun () -> Scanf.scanf "%d"
  (fun out_ ->
      (Scanf.scanf "%[\n \010]" (fun _ -> out_))));;
let rec read_char_line =
  (fun n ->
      let tab = (Array.init_withenv n (fun i n ->
                                          Scanf.scanf "%c"
                                          (fun t ->
                                              let o = t in
                                              (n, o))) n) in
      (Scanf.scanf "%[\n \010]" (fun _ -> tab)));;
let rec read_char_matrix =
  (fun x y ->
      let tab = (Array.init_withenv y (fun z ->
                                          (fun (x, y) ->
                                              let m = (read_char_line x) in
                                              ((x, y), m))) (x, y)) in
      tab);;
let rec pathfind_aux =
  (fun cache tab x y posX posY ->
      let g = (fun cache tab x y posX posY ->
                  ()) in
      (if ((posX = (x - 1)) && (posY = (y - 1)))
       then 0
       else let h = (fun cache tab x y posX posY ->
                        (g cache tab x y posX posY)) in
       (if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
        then ((x * y) * 10)
        else let k = (fun cache tab x y posX posY ->
                         (h cache tab x y posX posY)) in
        (if (tab.(posY).(posX) = '#')
         then ((x * y) * 10)
         else let l = (fun cache tab x y posX posY ->
                          (k cache tab x y posX posY)) in
         (if (cache.(posY).(posX) <> (- 1))
          then cache.(posY).(posX)
          else (cache.(posY).(posX) <- ((x * y) * 10); let val1 = (pathfind_aux cache tab x y (posX + 1) posY) in
          let val2 = (pathfind_aux cache tab x y (posX - 1) posY) in
          let val3 = (pathfind_aux cache tab x y posX (posY - 1)) in
          let val4 = (pathfind_aux cache tab x y posX (posY + 1)) in
          let out_ = (1 + (min4 val1 val2 val3 val4)) in
          (cache.(posY).(posX) <- out_; out_)))))));;
let rec pathfind =
  (fun tab x y ->
      let cache = (Array.init_withenv y (fun i ->
                                            (fun (tab, x, y) ->
                                                let tmp = (Array.init_withenv x (fun
                                                 j ->
                                                (fun (i, tab, x, y) ->
                                                    begin
                                                      (Printf.printf "%c" tab.(i).(j));
                                                      let f = (- 1) in
                                                      ((i, tab, x, y), f)
                                                      end
                                                    )) (i, tab, x, y)) in
                                                begin
                                                  (Printf.printf "%s" "\n");
                                                  let e = tmp in
                                                  ((tab, x, y), e)
                                                  end
                                                )) (tab, x, y)) in
      (pathfind_aux cache tab x y 0 0));;
let rec main =
  let x = (read_int ()) in
  let y = (read_int ()) in
  begin
    (Printf.printf "%d" x);
    (Printf.printf "%s" " ");
    (Printf.printf "%d" y);
    (Printf.printf "%s" "\n");
    let tab = (read_char_matrix x y) in
    let result = (pathfind tab x y) in
    (Printf.printf "%d" result)
    end
  ;;

