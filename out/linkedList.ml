type intlist = {
  mutable head : int;
  mutable tail : intlist;
};;
let cons list i =
  let out0 = {head=i;
  tail=list} in
  out0
let is_empty _foo =
  true
let rec rev2 acc torev =
  if is_empty torev then
    acc
  else
    let _acc2 = {head=torev.head;
    tail=acc} in
    rev2 acc torev.tail
let rev empty torev =
  rev2 empty torev
let test empty =
  let list = ref( empty ) in
  let i = ref( - 1 ) in
  while (!i) <> 0 do
    Scanf.scanf "%d" (fun c -> i := c);
    if (!i) <> 0 then
      list := cons (!list) (!i)
  done
let () =
 
  () 
 