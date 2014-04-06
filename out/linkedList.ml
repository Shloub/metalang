type intlist = {
  mutable head : int;
  mutable tail : intlist;
};;

let cons list i =
  let out_ = {
    head=i;
    tail=list;
  } in
  out_

let rec rev2 empty acc torev =
  if torev = empty then
    acc
  else
    begin
      let _acc2 = {
        head=torev.head;
        tail=acc;
      } in
      rev2 empty acc torev.tail
    end

let rev empty torev =
  rev2 empty empty torev

let test empty =
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
 