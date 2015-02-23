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

type gamestate = {mutable cases : int array array; mutable firstToPlay : bool; mutable note : int; mutable ended : bool;}
type move = {mutable x : int; mutable y : int;}
let print_state g =
  (
    (Printf.printf "\n|" );
    let rec p y =
      (if (y <= 2)
       then let rec q x =
              (if (x <= 2)
               then (
                      (if (g.cases.(x).(y) = 0)
                       then (Printf.printf " ")
                       else (if (g.cases.(x).(y) = 1)
                             then (Printf.printf "O")
                             else (Printf.printf "X")));
                      (Printf.printf "|" );
                      (q (x + 1))
                      )
               
               else (if (y <> 2)
                     then (
                            (Printf.printf "\n|-|-|-|\n|" );
                            (p (y + 1))
                            )
                     
                     else (p (y + 1)))) in
              (q 0)
       else (Printf.printf "\n")) in
      (p 0)
    )
  
let eval0 g =
  let win = 0 in
  let freecase = 0 in
  let rec n y freecase win =
    (if (y <= 2)
     then let col = (- 1) in
     let lin = (- 1) in
     let rec o x col freecase lin =
       (if (x <= 2)
        then let freecase = (if (g.cases.(x).(y) = 0)
                             then let freecase = (freecase + 1) in
                             freecase
                             else freecase) in
        let colv = g.cases.(x).(y) in
        let linv = g.cases.(y).(x) in
        let col = (if ((col = (- 1)) && (colv <> 0))
                   then let col = colv in
                   col
                   else (if (colv <> col)
                         then let col = (- 2) in
                         col
                         else col)) in
        (if ((lin = (- 1)) && (linv <> 0))
         then let lin = linv in
         (o (x + 1) col freecase lin)
         else (if (linv <> lin)
               then let lin = (- 2) in
               (o (x + 1) col freecase lin)
               else (o (x + 1) col freecase lin)))
        else (if (col >= 0)
              then let win = col in
              (n (y + 1) freecase win)
              else (if (lin >= 0)
                    then let win = lin in
                    (n (y + 1) freecase win)
                    else (n (y + 1) freecase win)))) in
       (o 0 col freecase lin)
     else let rec l x win =
            (if (x <= 2)
             then let win = (if (((g.cases.(0).(0) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(2) = x))
                             then let win = x in
                             win
                             else win) in
             (if (((g.cases.(0).(2) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(0) = x))
              then let win = x in
              (l (x + 1) win)
              else (l (x + 1) win))
             else (
                    g.ended <- ((win <> 0) || (freecase = 0));
                    (if (win = 1)
                     then g.note <- 1000
                     else (if (win = 2)
                           then g.note <- (- 1000)
                           else g.note <- 0))
                    )
             ) in
            (l 1 win)) in
    (n 0 freecase win)
let apply_move_xy x y g =
  let player = 2 in
  let player = (if g.firstToPlay
                then let player = 1 in
                player
                else player) in
  (
    g.cases.(x).(y) <- player;
    g.firstToPlay <- (not g.firstToPlay)
    )
  
let apply_move m g =
  (
    (apply_move_xy m.x m.y g);
    ()
    )
  
let cancel_move_xy x y g =
  (
    g.cases.(x).(y) <- 0;
    g.firstToPlay <- (not g.firstToPlay);
    g.ended <- false
    )
  
let cancel_move m g =
  (
    (cancel_move_xy m.x m.y g);
    ()
    )
  
let can_move_xy x y g =
  (g.cases.(x).(y) = 0)
let can_move m g =
  (can_move_xy m.x m.y g)
let rec minmax g =
  (
    (eval0 g);
    (if g.ended
     then g.note
     else let maxNote = (- 10000) in
     let maxNote = (if (not g.firstToPlay)
                    then let maxNote = 10000 in
                    maxNote
                    else maxNote) in
     let rec h x maxNote =
       (if (x <= 2)
        then let rec k y maxNote =
               (if (y <= 2)
                then (if (can_move_xy x y g)
                      then (
                             (apply_move_xy x y g);
                             let currentNote = (minmax g) in
                             (
                               (cancel_move_xy x y g);
                               (*  Minimum ou Maximum selon le coté ou l'on joue *)
                               (if ((currentNote > maxNote) = g.firstToPlay)
                                then let maxNote = currentNote in
                                (k (y + 1) maxNote)
                                else (k (y + 1) maxNote))
                               )
                             
                             )
                      
                      else (k (y + 1) maxNote))
                else (h (x + 1) maxNote)) in
               (k 0 maxNote)
        else maxNote) in
       (h 0 maxNote))
    )
  
let play g =
  let minMove = {x=0;
  y=0} in
  let minNote = 10000 in
  let rec e x minNote =
    (if (x <= 2)
     then let rec f y minNote =
            (if (y <= 2)
             then (if (can_move_xy x y g)
                   then (
                          (apply_move_xy x y g);
                          let currentNote = (minmax g) in
                          (
                            (Printf.printf "%d, %d, %d\n" x y currentNote);
                            (cancel_move_xy x y g);
                            (if (currentNote < minNote)
                             then let minNote = currentNote in
                             (
                               minMove.x <- x;
                               minMove.y <- y;
                               (f (y + 1) minNote)
                               )
                             
                             else (f (y + 1) minNote))
                            )
                          
                          )
                   
                   else (f (y + 1) minNote))
             else (e (x + 1) minNote)) in
            (f 0 minNote)
     else (
            (Printf.printf "%d%d\n" minMove.x minMove.y);
            minMove
            )
     ) in
    (e 0 minNote)
let init0 () =
  ((fun  (b, cases) -> {cases=cases;
  firstToPlay=true;
  note=0;
  ended=false}) (Array.init_withenv 3 (fun  i b -> ((fun  (d, tab) -> let a = tab in
  ((), a)) (Array.init_withenv 3 (fun  j d -> let c = 0 in
  ((), c)) ()))) ()))
let read_move () =
  Scanf.scanf "%d"
  (fun  x -> (
               (Scanf.scanf "%[\n \010]" (fun _ -> ()));
               Scanf.scanf "%d"
               (fun  y -> (
                            (Scanf.scanf "%[\n \010]" (fun _ -> ()));
                            {x=x;
                            y=y}
                            )
               )
               )
  )
let main =
  let rec r i =
    (if (i <= 1)
     then let state = (init0 ()) in
     (
       (apply_move {x=1;
       y=1} state);
       (apply_move {x=0;
       y=0} state);
       let rec s () =
         (if (not state.ended)
          then (
                 (print_state state);
                 (apply_move (play state) state);
                 (eval0 state);
                 (print_state state);
                 (if (not state.ended)
                  then (
                         (apply_move (play state) state);
                         (eval0 state);
                         (s ())
                         )
                  
                  else (s ()))
                 )
          
          else (
                 (print_state state);
                 (Printf.printf "%d\n" state.note);
                 (r (i + 1))
                 )
          ) in
         (s ())
       )
     
     else ()) in
    (r 0)

