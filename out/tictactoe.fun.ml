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

type gamestate = {mutable cases : int array array; mutable firstToPlay : bool; mutable note : int; mutable ended : bool;};;
type move = {mutable x : int; mutable y : int;};;
let rec print_state =
  (fun g ->
      begin
        (Printf.printf "%s" "\n|");
        let ce = 0 in
        let cf = 2 in
        let rec bx y g =
          (if (y <= cf)
           then let cc = 0 in
           let cd = 2 in
           let rec bz x g =
             (if (x <= cd)
              then let ca = (fun g ->
                                begin
                                  (Printf.printf "%s" "|");
                                  (bz (x + 1) g)
                                  end
                                ) in
              (if (g.cases.(x).(y) = 0)
               then begin
                      (Printf.printf "%s" " ");
                      (ca g)
                      end
               
               else let cb = (fun g ->
                                 (ca g)) in
               (if (g.cases.(x).(y) = 1)
                then begin
                       (Printf.printf "%s" "O");
                       (cb g)
                       end
                
                else begin
                       (Printf.printf "%s" "X");
                       (cb g)
                       end
                ))
              else let by = (fun g ->
                                (bx (y + 1) g)) in
              (if (y <> 2)
               then begin
                      (Printf.printf "%s" "\n|-|-|-|\n|");
                      (by g)
                      end
               
               else (by g))) in
             (bz cc g)
           else (Printf.printf "%s" "\n")) in
          (bx ce g)
        end
      );;
let rec eval_ =
  (fun g ->
      let win = 0 in
      let freecase = 0 in
      let bv = 0 in
      let bw = 2 in
      let rec bk y freecase win g =
        (if (y <= bw)
         then let col = (- 1) in
         let lin = (- 1) in
         let bt = 0 in
         let bu = 2 in
         let rec bn x lin col freecase win g =
           (if (x <= bu)
            then let bs = (fun lin col freecase win g ->
                              let colv = g.cases.(x).(y) in
                              let linv = g.cases.(y).(x) in
                              let bq = (fun linv colv lin col freecase win g ->
                                           let bo = (fun linv colv lin col freecase win g ->
                                                        (bn (x + 1) lin col freecase win g)) in
                                           (if ((lin = (- 1)) && (linv <> 0))
                                            then let lin = linv in
                                            (bo linv colv lin col freecase win g)
                                            else let bp = (fun linv colv lin col freecase win g ->
                                                              (bo linv colv lin col freecase win g)) in
                                            (if (linv <> lin)
                                             then let lin = (- 2) in
                                             (bp linv colv lin col freecase win g)
                                             else (bp linv colv lin col freecase win g)))) in
                              (if ((col = (- 1)) && (colv <> 0))
                               then let col = colv in
                               (bq linv colv lin col freecase win g)
                               else let br = (fun linv colv lin col freecase win g ->
                                                 (bq linv colv lin col freecase win g)) in
                               (if (colv <> col)
                                then let col = (- 2) in
                                (br linv colv lin col freecase win g)
                                else (br linv colv lin col freecase win g)))) in
            (if (g.cases.(x).(y) = 0)
             then let freecase = (freecase + 1) in
             (bs lin col freecase win g)
             else (bs lin col freecase win g))
            else let bl = (fun lin col freecase win g ->
                              (bk (y + 1) freecase win g)) in
            (if (col >= 0)
             then let win = col in
             (bl lin col freecase win g)
             else let bm = (fun lin col freecase win g ->
                               (bl lin col freecase win g)) in
             (if (lin >= 0)
              then let win = lin in
              (bm lin col freecase win g)
              else (bm lin col freecase win g)))) in
           (bn bt lin col freecase win g)
         else let bi = 1 in
         let bj = 2 in
         let rec bf x freecase win g =
           (if (x <= bj)
            then let bh = (fun freecase win g ->
                              let bg = (fun freecase win g ->
                                           (bf (x + 1) freecase win g)) in
                              (if (((g.cases.(0).(2) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(0) = x))
                               then let win = x in
                               (bg freecase win g)
                               else (bg freecase win g))) in
            (if (((g.cases.(0).(0) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(2) = x))
             then let win = x in
             (bh freecase win g)
             else (bh freecase win g))
            else (g.ended <- ((win <> 0) || (freecase = 0)); let bd = (fun
             freecase win g ->
            ()) in
            (if (win = 1)
             then (g.note <- 1000; (bd freecase win g))
             else let be = (fun freecase win g ->
                               (bd freecase win g)) in
             (if (win = 2)
              then (g.note <- (- 1000); (be freecase win g))
              else (g.note <- 0; (be freecase win g)))))) in
           (bf bi freecase win g)) in
        (bk bv freecase win g));;
let rec apply_move_xy =
  (fun x y g ->
      let player = 2 in
      let bc = (fun player x y g ->
                   (g.cases.(x).(y) <- player; (g.firstToPlay <- (not g.firstToPlay); ()))) in
      (if g.firstToPlay
       then let player = 1 in
       (bc player x y g)
       else (bc player x y g)));;
let rec apply_move =
  (fun m g ->
      begin
        (apply_move_xy m.x m.y g);
        ()
        end
      );;
let rec cancel_move_xy =
  (fun x y g ->
      (g.cases.(x).(y) <- 0; (g.firstToPlay <- (not g.firstToPlay); (g.ended <- false; ()))));;
let rec cancel_move =
  (fun m g ->
      begin
        (cancel_move_xy m.x m.y g);
        ()
        end
      );;
let rec can_move_xy =
  (fun x y g ->
      (g.cases.(x).(y) = 0));;
let rec can_move =
  (fun m g ->
      (can_move_xy m.x m.y g));;
let rec minmax =
  (fun g ->
      begin
        (eval_ g);
        let bb = (fun g ->
                     let maxNote = (- 10000) in
                     let ba = (fun maxNote g ->
                                  let w = 0 in
                                  let z = 2 in
                                  let rec q x maxNote g =
                                    (if (x <= z)
                                     then let u = 0 in
                                     let v = 2 in
                                     let rec r y maxNote g =
                                       (if (y <= v)
                                        then let s = (fun maxNote g ->
                                                         (r (y + 1) maxNote g)) in
                                        (if (can_move_xy x y g)
                                         then begin
                                                (apply_move_xy x y g);
                                                let currentNote = (minmax g) in
                                                begin
                                                  (cancel_move_xy x y g);
                                                  (*  Minimum ou Maximum selon le coté ou l'on joue *)
                                                  let t = (fun currentNote maxNote g ->
                                                              (s maxNote g)) in
                                                  (if ((currentNote > maxNote) = g.firstToPlay)
                                                   then let maxNote = currentNote in
                                                   (t currentNote maxNote g)
                                                   else (t currentNote maxNote g))
                                                  end
                                                
                                                end
                                         
                                         else (s maxNote g))
                                        else (q (x + 1) maxNote g)) in
                                       (r u maxNote g)
                                     else maxNote) in
                                    (q w maxNote g)) in
                     (if (not g.firstToPlay)
                      then let maxNote = 10000 in
                      (ba maxNote g)
                      else (ba maxNote g))) in
        (if g.ended
         then g.note
         else (bb g))
        end
      );;
let rec play =
  (fun g ->
      let minMove = {x=0;
      y=0} in
      let minNote = 10000 in
      let o = 0 in
      let p = 2 in
      let rec e x minNote minMove g =
        (if (x <= p)
         then let l = 0 in
         let n = 2 in
         let rec f y minNote minMove g =
           (if (y <= n)
            then let h = (fun minNote minMove g ->
                             (f (y + 1) minNote minMove g)) in
            (if (can_move_xy x y g)
             then begin
                    (apply_move_xy x y g);
                    let currentNote = (minmax g) in
                    begin
                      (Printf.printf "%d" x);
                      (Printf.printf "%s" ", ");
                      (Printf.printf "%d" y);
                      (Printf.printf "%s" ", ");
                      (Printf.printf "%d" currentNote);
                      (Printf.printf "%s" "\n");
                      (cancel_move_xy x y g);
                      let k = (fun currentNote minNote minMove g ->
                                  (h minNote minMove g)) in
                      (if (currentNote < minNote)
                       then let minNote = currentNote in
                       (minMove.x <- x; (minMove.y <- y; (k currentNote minNote minMove g)))
                       else (k currentNote minNote minMove g))
                      end
                    
                    end
             
             else (h minNote minMove g))
            else (e (x + 1) minNote minMove g)) in
           (f l minNote minMove g)
         else begin
                (Printf.printf "%d" minMove.x);
                (Printf.printf "%d" minMove.y);
                (Printf.printf "%s" "\n");
                minMove
                end
         ) in
        (e o minNote minMove g));;
let rec init_ =
  (fun () -> let b = 3 in
  let cases = (Array.init_withenv b (fun i b ->
                                        let a = 3 in
                                        let tab = (Array.init_withenv a (fun
                                         j ->
                                        (fun (a, i, b) ->
                                            let d = 0 in
                                            ((a, i, b), d))) (a, i, b)) in
                                        let c = tab in
                                        (b, c)) b) in
  {cases=cases;
  firstToPlay=true;
  note=0;
  ended=false});;
let rec read_move =
  (fun () -> Scanf.scanf "%d"
  (fun x ->
      (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d"
      (fun y ->
          (Scanf.scanf "%[\n \010]" (fun _ -> {x=x;
          y=y})))))));;
let rec main =
  let ck = 0 in
  let cl = 1 in
  let rec cg i =
    (if (i <= cl)
     then let state = (init_ ()) in
     begin
       (apply_move {x=1;
       y=1} state);
       (apply_move {x=0;
       y=0} state);
       let rec ci state =
         (if (not state.ended)
          then begin
                 (print_state state);
                 (apply_move (play state) state);
                 (eval_ state);
                 (print_state state);
                 let cj = (fun state ->
                              (ci state)) in
                 (if (not state.ended)
                  then begin
                         (apply_move (play state) state);
                         (eval_ state);
                         (cj state)
                         end
                  
                  else (cj state))
                 end
          
          else begin
                 (print_state state);
                 (Printf.printf "%d" state.note);
                 (Printf.printf "%s" "\n");
                 (cg (i + 1))
                 end
          ) in
         (ci state)
       end
     
     else ()) in
    (cg ck);;

