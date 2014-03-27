type intlist = {
  mutable head : int;
  mutable tail : intlist;
};;

let rec cons list i =
  let a = {
    head=i;
    tail=list;
  } in
  let out_ = a in
  out_

let rec rev2 empty acc torev =
  if torev = empty then
    acc
  else
    begin
      let b = {
        head=torev.head;
        tail=acc;
      } in
      let _acc2 = b in
      rev2 empty acc torev.tail
    end

let rec rev empty torev =
  rev2 empty empty torev

let rec test empty =
  let list = ref( empty ) in
  let i = ref( -1 ) in
  while (!i) <> 0
  do
      Scanf.scanf "%d" (fun value -> i := value);
      if (!i) <> 0 then
        list := cons (!list) (!i)
  done

let () =
begin
   ()
end
 