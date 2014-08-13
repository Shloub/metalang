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
      let out_ = {head=i;
      tail=list} in
      out_);;
let rec rev2 =
  (fun empty acc torev ->
      let e = (fun empty acc torev ->
                  ()) in
      (if (torev = empty)
       then acc
       else let acc2 = {head=torev.head;
       tail=acc} in
       (rev2 empty acc torev.tail)));;
let rec rev =
  (fun empty torev ->
      (rev2 empty empty torev));;
let rec test =
  (fun empty ->
      let list = empty in
      let i = (- 1) in
      let rec b i list empty =
        (if (i <> 0)
         then Scanf.scanf "%d"
         (fun d ->
             let i = d in
             let c = (fun i list empty ->
                         (b i list empty)) in
             (if (i <> 0)
              then let list = (cons list i) in
              (c i list empty)
              else (c i list empty)))
         else ()) in
        (b i list empty));;
let rec main =
  ();;

