module IntSet = Map.Make (struct
  type t = int
  let compare : int -> int -> int = Pervasives.compare
end)

let main =
  ((fun i ->
       ((fun i ->
            ((fun be ->
                 Printf.printf "%d" be;
                 ((fun bd ->
                      Printf.printf "%s" bd;
                      ((fun i ->
                           ((fun bc ->
                                Printf.printf "%d" bc;
                                ((fun bb ->
                                     Printf.printf "%s" bb;
                                     ((fun i ->
                                          ((fun ba ->
                                               Printf.printf "%d" ba;
                                               ((fun z ->
                                                    Printf.printf "%s" z;
                                                    ((fun i ->
                                                         ((fun y ->
                                                              Printf.printf "%d" y;
                                                              ((fun x ->
                                                                   Printf.printf "%s" x;
                                                                   ((fun
                                                                    i ->
                                                                   ((fun
                                                                    w ->
                                                                   Printf.printf "%d" w;
                                                                   ((fun
                                                                    v ->
                                                                   Printf.printf "%s" v;
                                                                   ((fun
                                                                    i ->
                                                                   ((fun
                                                                    u ->
                                                                   Printf.printf "%d" u;
                                                                   ((fun
                                                                    t ->
                                                                   Printf.printf "%s" t;
                                                                   ((fun
                                                                    i ->
                                                                   ((fun
                                                                    s ->
                                                                   Printf.printf "%d" s;
                                                                   ((fun
                                                                    r ->
                                                                   Printf.printf "%s" r;
                                                                   (* 
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
 *) ((fun
                                                                    q ->
                                                                   Printf.printf "%d" q;
                                                                   ((fun
                                                                    p ->
                                                                   Printf.printf "%s" p;
                                                                   ((fun
                                                                    o ->
                                                                   Printf.printf "%d" o;
                                                                   ((fun
                                                                    n ->
                                                                   Printf.printf "%s" n;
                                                                   ((fun
                                                                    m ->
                                                                   Printf.printf "%d" m;
                                                                   ((fun
                                                                    l ->
                                                                   Printf.printf "%s" l;
                                                                   ((fun
                                                                    k ->
                                                                   Printf.printf "%d" k;
                                                                   ((fun
                                                                    j ->
                                                                   Printf.printf "%s" j;
                                                                   ((fun
                                                                    h ->
                                                                   Printf.printf "%d" h;
                                                                   ((fun
                                                                    g ->
                                                                   Printf.printf "%s" g;
                                                                   ((fun
                                                                    f ->
                                                                   Printf.printf "%d" f;
                                                                   ((fun
                                                                    e ->
                                                                   Printf.printf "%s" e;
                                                                   ((fun
                                                                    d ->
                                                                   Printf.printf "%d" d;
                                                                   ((fun
                                                                    c ->
                                                                   Printf.printf "%s" c;
                                                                   ((fun
                                                                    b ->
                                                                   Printf.printf "%d" b;
                                                                   ((fun
                                                                    a ->
                                                                   Printf.printf "%s" a;
                                                                   ()) "\n")) ((- 117) mod (- 17)))) "\n")) ((- 117) mod 17))) "\n")) (117 mod (- 17)))) "\n")) (117 mod 17))) "\n")) ((- 117) / (- 17)))) "\n")) ((- 117) / 17))) "\n")) (117 / (- 17)))) "\n")) (117 / 17))) "\n")) i)) (i - 1))) "\n")) i)) (i / 3))) "\n")) i)) (i + 1))) "\n")) i)) (i / 2))) "\n")) i)) (i * 13))) "\n")) i)) (i + 55))) "\n")) i)) (i - 1))) 0);;

