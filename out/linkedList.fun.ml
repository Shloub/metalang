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

type intlist = {mutable head : int; mutable tail : intlist;};;
let rec cons =
  (fun list i ->
      ((fun out_ ->
           out_) {head=i;
      tail=list}));;
let rec rev2 =
  (fun empty acc torev ->
      ((fun e ->
           (if (torev = empty)
            then acc
            else ((fun acc2 ->
                      (rev2 empty acc torev.tail)) {head=torev.head;
            tail=acc}))) (fun empty acc torev ->
                             ())));;
let rec rev =
  (fun empty torev ->
      (rev2 empty empty torev));;
let rec test =
  (fun empty ->
      ((fun list ->
           ((fun i ->
                let rec b i list empty =
                  (if (i <> 0)
                   then Scanf.scanf "%d" (fun d ->
                                             ((fun i ->
                                                  ((fun c ->
                                                       (if (i <> 0)
                                                        then ((fun list ->
                                                                  (c i list empty)) (cons list i))
                                                        else (c i list empty))) (fun
                                                   i list empty ->
                                                  (b i list empty)))) d))
                   else ()) in
                  (b i list empty)) (- 1))) empty));;
let rec main =
  ();;

