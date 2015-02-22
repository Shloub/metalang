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
    let bj = 0 in
    let bk = 2 in
    let rec bf y =
      (if (y <= bk)
       then let bh = 0 in
       let bi = 2 in
       let rec bg x =
         (if (x <= bi)
          then (
                 (if (g.cases.(x).(y) = 0)
                  then (Printf.printf " ")
                  else (
                         (if (g.cases.(x).(y) = 1)
                          then (Printf.printf "O")
                          else (Printf.printf "X"));
                         ()
                         )
                  );
                 (Printf.printf "|" );
                 (bg (x + 1))
                 )
          
          else (
                 (if (y <> 2)
                  then (Printf.printf "\n|-|-|-|\n|")
                  else ());
                 (bf (y + 1))
                 )
          ) in
         (bg bh)
       else (Printf.printf "\n")) in
      (bf bj)
    )
  
let eval0 g =
  let win = 0 in
  let freecase = 0 in
  let bd = 0 in
  let be = 2 in
  let rec z y freecase win =
    (if (y <= be)
     then let col = (- 1) in
     let lin = (- 1) in
     let bb = 0 in
     let bc = 2 in
     let rec ba x col freecase lin =
       (if (x <= bc)
        then let freecase = (if (g.cases.(x).(y) = 0)
                             then let freecase = (freecase + 1) in
                             freecase
                             else freecase) in
        let colv = g.cases.(x).(y) in
        let linv = g.cases.(y).(x) in
        let col = (if ((col = (- 1)) && (colv <> 0))
                   then let col = colv in
                   col
                   else let col = (if (colv <> col)
                                   then let col = (- 2) in
                                   col
                                   else col) in
                   col) in
        let lin = (if ((lin = (- 1)) && (linv <> 0))
                   then let lin = linv in
                   lin
                   else let lin = (if (linv <> lin)
                                   then let lin = (- 2) in
                                   lin
                                   else lin) in
                   lin) in
        (ba (x + 1) col freecase lin)
        else let win = (if (col >= 0)
                        then let win = col in
                        win
                        else let win = (if (lin >= 0)
                                        then let win = lin in
                                        win
                                        else win) in
                        win) in
        (z (y + 1) freecase win)) in
       (ba bb col freecase lin)
     else let v = 1 in
     let w = 2 in
     let rec u x win =
       (if (x <= w)
        then let win = (if (((g.cases.(0).(0) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(2) = x))
                        then let win = x in
                        win
                        else win) in
        let win = (if (((g.cases.(0).(2) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(0) = x))
                   then let win = x in
                   win
                   else win) in
        (u (x + 1) win)
        else (
               g.ended <- ((win <> 0) || (freecase = 0));
               (if (win = 1)
                then g.note <- 1000
                else (
                       (if (win = 2)
                        then g.note <- (- 1000)
                        else g.note <- 0);
                       ()
                       )
                );
               ()
               )
        ) in
       (u v win)) in
    (z bd freecase win)
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
     let s = 0 in
     let t = 2 in
     let rec o x maxNote =
       (if (x <= t)
        then let q = 0 in
        let r = 2 in
        let rec p y maxNote =
          (if (y <= r)
           then let maxNote = (if (can_move_xy x y g)
                               then (
                                      (apply_move_xy x y g);
                                      let currentNote = (minmax g) in
                                      (
                                        (cancel_move_xy x y g);
                                        (*  Minimum ou Maximum selon le coté ou l'on joue *)
                                        let maxNote = (if ((currentNote > maxNote) = g.firstToPlay)
                                                       then let maxNote = currentNote in
                                                       maxNote
                                                       else maxNote) in
                                        maxNote
                                        )
                                      
                                      )
                               
                               else maxNote) in
           (p (y + 1) maxNote)
           else (o (x + 1) maxNote)) in
          (p q maxNote)
        else maxNote) in
       (o s maxNote))
    )
  
let play g =
  let minMove = {x=0;
  y=0} in
  let minNote = 10000 in
  let l = 0 in
  let n = 2 in
  let rec e x minNote =
    (if (x <= n)
     then let h = 0 in
     let k = 2 in
     let rec f y minNote =
       (if (y <= k)
        then let minNote = (if (can_move_xy x y g)
                            then (
                                   (apply_move_xy x y g);
                                   let currentNote = (minmax g) in
                                   (
                                     (Printf.printf "%d, %d, %d\n" x y currentNote);
                                     (cancel_move_xy x y g);
                                     let minNote = (if (currentNote < minNote)
                                                    then let minNote = currentNote in
                                                    (
                                                      minMove.x <- x;
                                                      minMove.y <- y;
                                                      minNote
                                                      )
                                                    
                                                    else minNote) in
                                     minNote
                                     )
                                   
                                   )
                            
                            else minNote) in
        (f (y + 1) minNote)
        else (e (x + 1) minNote)) in
       (f h minNote)
     else (
            (Printf.printf "%d%d\n" minMove.x minMove.y);
            minMove
            )
     ) in
    (e l minNote)
let init0 () =
  ((fun  (b, cases) -> (
                         b;
                         {cases=cases;
                         firstToPlay=true;
                         note=0;
                         ended=false}
                         )
  ) (Array.init_withenv 3 (fun  i () -> ((fun  (d, tab) -> (
                                                             d;
                                                             let a = tab in
                                                             ((), a)
                                                             )
  ) (Array.init_withenv 3 (fun  j () -> let c = 0 in
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
  let bn = 0 in
  let bo = 1 in
  let rec bl i =
    (if (i <= bo)
     then let state = (init0 ()) in
     (
       (apply_move {x=1;
       y=1} state);
       (apply_move {x=0;
       y=0} state);
       let rec bm () =
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
                         ()
                         )
                  
                  else ());
                 (bm ())
                 )
          
          else (
                 (print_state state);
                 (Printf.printf "%d\n" state.note);
                 (bl (i + 1))
                 )
          ) in
         (bm ())
       )
     
     else ()) in
    (bl bn)

