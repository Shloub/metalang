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
      (Printf.printf "%s" "\n|";
      ((fun ce cf ->
           let rec bx y g =
             (if (y <= cf)
              then ((fun cc cd ->
                        let rec bz x g =
                          (if (x <= cd)
                           then ((fun ca ->
                                     (if (g.cases.(x).(y) = 0)
                                      then (Printf.printf "%s" " ";
                                      (ca g))
                                      else ((fun cb ->
                                                (if (g.cases.(x).(y) = 1)
                                                 then (Printf.printf "%s" "O";
                                                 (cb g))
                                                 else (Printf.printf "%s" "X";
                                                 (cb g)))) (fun g ->
                                                               (ca g))))) (fun
                            g ->
                           (Printf.printf "%s" "|";
                           (bz (x + 1) g))))
                           else ((fun by ->
                                     (if (y <> 2)
                                      then (Printf.printf "%s" "\n|-|-|-|\n|";
                                      (by g))
                                      else (by g))) (fun g ->
                                                        (bx (y + 1) g)))) in
                          (bz cc g)) 0 2)
              else (Printf.printf "%s" "\n";
              ())) in
             (bx ce g)) 0 2)));;
let rec eval_ =
  (fun g ->
      ((fun win ->
           ((fun freecase ->
                ((fun bv bw ->
                     let rec bk y freecase win g =
                       (if (y <= bw)
                        then ((fun col ->
                                  ((fun lin ->
                                       ((fun bt bu ->
                                            let rec bn x lin col freecase win g =
                                              (if (x <= bu)
                                               then ((fun bs ->
                                                         (if (g.cases.(x).(y) = 0)
                                                          then ((fun freecase ->
                                                                    (bs lin col freecase win g)) (freecase + 1))
                                                          else (bs lin col freecase win g))) (fun
                                                lin col freecase win g ->
                                               ((fun colv ->
                                                    ((fun linv ->
                                                         ((fun bq ->
                                                              (if ((col = (- 1)) && (colv <> 0))
                                                               then ((fun
                                                                col ->
                                                               (bq linv colv lin col freecase win g)) colv)
                                                               else ((fun
                                                                br ->
                                                               (if (colv <> col)
                                                                then ((fun
                                                                 col ->
                                                                (br linv colv lin col freecase win g)) (- 2))
                                                                else (br linv colv lin col freecase win g))) (fun
                                                                linv colv lin col freecase win g ->
                                                               (bq linv colv lin col freecase win g))))) (fun
                                                          linv colv lin col freecase win g ->
                                                         ((fun bo ->
                                                              (if ((lin = (- 1)) && (linv <> 0))
                                                               then ((fun
                                                                lin ->
                                                               (bo linv colv lin col freecase win g)) linv)
                                                               else ((fun
                                                                bp ->
                                                               (if (linv <> lin)
                                                                then ((fun
                                                                 lin ->
                                                                (bp linv colv lin col freecase win g)) (- 2))
                                                                else (bp linv colv lin col freecase win g))) (fun
                                                                linv colv lin col freecase win g ->
                                                               (bo linv colv lin col freecase win g))))) (fun
                                                          linv colv lin col freecase win g ->
                                                         (bn (x + 1) lin col freecase win g)))))) g.cases.(y).(x))) g.cases.(x).(y))))
                                               else ((fun bl ->
                                                         (if (col >= 0)
                                                          then ((fun win ->
                                                                    (bl lin col freecase win g)) col)
                                                          else ((fun bm ->
                                                                    (
                                                                    if (lin >= 0)
                                                                    then ((fun
                                                                     win ->
                                                                    (bm lin col freecase win g)) lin)
                                                                    else (bm lin col freecase win g))) (fun
                                                           lin col freecase win g ->
                                                          (bl lin col freecase win g))))) (fun
                                                lin col freecase win g ->
                                               (bk (y + 1) freecase win g)))) in
                                              (bn bt lin col freecase win g)) 0 2)) (- 1))) (- 1))
                        else ((fun bi bj ->
                                  let rec bf x freecase win g =
                                    (if (x <= bj)
                                     then ((fun bh ->
                                               (if (((g.cases.(0).(0) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(2) = x))
                                                then ((fun win ->
                                                          (bh freecase win g)) x)
                                                else (bh freecase win g))) (fun
                                      freecase win g ->
                                     ((fun bg ->
                                          (if (((g.cases.(0).(2) = x) && (g.cases.(1).(1) = x)) && (g.cases.(2).(0) = x))
                                           then ((fun win ->
                                                     (bg freecase win g)) x)
                                           else (bg freecase win g))) (fun
                                      freecase win g ->
                                     (bf (x + 1) freecase win g)))))
                                     else (g.ended <- ((win <> 0) || (freecase = 0)); ((fun
                                      bd ->
                                     (if (win = 1)
                                      then (g.note <- 1000; (bd freecase win g))
                                      else ((fun be ->
                                                (if (win = 2)
                                                 then (g.note <- (- 1000); (be freecase win g))
                                                 else (g.note <- 0; (be freecase win g)))) (fun
                                       freecase win g ->
                                      (bd freecase win g))))) (fun freecase win g ->
                                                                  ())))) in
                                    (bf bi freecase win g)) 1 2)) in
                       (bk bv freecase win g)) 0 2)) 0)) 0));;
let rec apply_move_xy =
  (fun x y g ->
      ((fun player ->
           ((fun bc ->
                (if g.firstToPlay
                 then ((fun player ->
                           (bc player x y g)) 1)
                 else (bc player x y g))) (fun player x y g ->
                                              (g.cases.(x).(y) <- player; (g.firstToPlay <- (not g.firstToPlay); ()))))) 2));;
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
        ((fun bb ->
             (if g.ended
              then g.note
              else (bb g))) (fun g ->
                                ((fun maxNote ->
                                     ((fun ba ->
                                          (if (not g.firstToPlay)
                                           then ((fun maxNote ->
                                                     (ba maxNote g)) 10000)
                                           else (ba maxNote g))) (fun
                                      maxNote g ->
                                     ((fun w z ->
                                          let rec q x maxNote g =
                                            (if (x <= z)
                                             then ((fun u v ->
                                                       let rec r y maxNote g =
                                                         (if (y <= v)
                                                          then ((fun s ->
                                                                    (
                                                                    if (can_move_xy x y g)
                                                                    then 
                                                                    begin
                                                                    (apply_move_xy x y g);
                                                                    ((fun
                                                                     currentNote ->
                                                                    begin
                                                                    (cancel_move_xy x y g);
                                                                    (*  Minimum ou Maximum selon le coté ou l'on joue *)
                                                                    ((fun
                                                                     t ->
                                                                    (
                                                                    if ((currentNote > maxNote) = g.firstToPlay)
                                                                    then ((fun
                                                                     maxNote ->
                                                                    (t currentNote maxNote g)) currentNote)
                                                                    else (t currentNote maxNote g))) (fun
                                                                     currentNote maxNote g ->
                                                                    (s maxNote g)))
                                                                    end
                                                                    ) (minmax g))
                                                                    end
                                                                    
                                                                    else (s maxNote g))) (fun
                                                           maxNote g ->
                                                          (r (y + 1) maxNote g)))
                                                          else (q (x + 1) maxNote g)) in
                                                         (r u maxNote g)) 0 2)
                                             else maxNote) in
                                            (q w maxNote g)) 0 2)))) (- 10000))))
        end
      );;
let rec play =
  (fun g ->
      ((fun minMove ->
           ((fun minNote ->
                ((fun o p ->
                     let rec e x minNote minMove g =
                       (if (x <= p)
                        then ((fun l n ->
                                  let rec f y minNote minMove g =
                                    (if (y <= n)
                                     then ((fun h ->
                                               (if (can_move_xy x y g)
                                                then begin
                                                       (apply_move_xy x y g);
                                                       ((fun currentNote ->
                                                            (Printf.printf "%d" x;
                                                            (Printf.printf "%s" ", ";
                                                            (Printf.printf "%d" y;
                                                            (Printf.printf "%s" ", ";
                                                            (Printf.printf "%d" currentNote;
                                                            (Printf.printf "%s" "\n";
                                                            begin
                                                              (cancel_move_xy x y g);
                                                              ((fun k ->
                                                                   (if (currentNote < minNote)
                                                                    then ((fun
                                                                     minNote ->
                                                                    (minMove.x <- x; (minMove.y <- y; (k currentNote minNote minMove g)))) currentNote)
                                                                    else (k currentNote minNote minMove g))) (fun
                                                               currentNote minNote minMove g ->
                                                              (h minNote minMove g)))
                                                              end
                                                            ))))))) (minmax g))
                                                       end
                                                
                                                else (h minNote minMove g))) (fun
                                      minNote minMove g ->
                                     (f (y + 1) minNote minMove g)))
                                     else (e (x + 1) minNote minMove g)) in
                                    (f l minNote minMove g)) 0 2)
                        else (Printf.printf "%d" minMove.x;
                        (Printf.printf "%d" minMove.y;
                        (Printf.printf "%s" "\n";
                        minMove)))) in
                       (e o minNote minMove g)) 0 2)) 10000)) {x=0;
      y=0}));;
let rec init_ =
  (fun () -> ((fun b ->
                  ((fun cases ->
                       {cases=cases;
                       firstToPlay=true;
                       note=0;
                       ended=false}) ((Array.init_withenv b (fun i ->
                                                                (fun (b) ->
                                                                    ((fun
                                                                     a ->
                                                                    ((fun
                                                                     tab ->
                                                                    ((fun
                                                                     c ->
                                                                    ((b), c)) tab)) ((Array.init_withenv a (fun
                                                                     j ->
                                                                    (fun
                                                                     (a, i, b) ->
                                                                    ((fun
                                                                     d ->
                                                                    ((a, i, b), d)) 0))) ) (a, i, b)))) 3))) ) (b)))) 3));;
let rec read_move =
  (fun () -> Scanf.scanf "%d" (fun x ->
                                  (Scanf.scanf "%[\n \010]" (fun _ -> Scanf.scanf "%d" (fun
                                   y ->
                                  (Scanf.scanf "%[\n \010]" (fun _ -> {x=x;
                                  y=y})))))));;
let rec main =
  ((fun ck cl ->
       let rec cg i =
         (if (i <= cl)
          then ((fun state ->
                    begin
                      (apply_move {x=1;
                      y=1} state);
                      begin
                        (apply_move {x=0;
                        y=0} state);
                        let rec ci state =
                          (if (not state.ended)
                           then begin
                                  (print_state state);
                                  begin
                                    (apply_move (play state) state);
                                    begin
                                      (eval_ state);
                                      begin
                                        (print_state state);
                                        ((fun cj ->
                                             (if (not state.ended)
                                              then begin
                                                     (apply_move (play state) state);
                                                     begin
                                                       (eval_ state);
                                                       (cj state)
                                                       end
                                                     
                                                     end
                                              
                                              else (cj state))) (fun state ->
                                                                    (ci state)))
                                        end
                                      
                                      end
                                    
                                    end
                                  
                                  end
                           
                           else begin
                                  (print_state state);
                                  (Printf.printf "%d" state.note;
                                  (Printf.printf "%s" "\n";
                                  (cg (i + 1))))
                                  end
                           ) in
                          (ci state)
                        end
                      
                      end
                    ) (init_ ()))
          else ()) in
         (cg ck)) 0 1);;

