type tuple_int_int = {
  mutable tuple_int_int_field_0 : int;
  mutable tuple_int_int_field_1 : int;
};;

let rec f tuple_ =
  let c = tuple_ in
  let a = c.tuple_int_int_field_0 in
  let b = c.tuple_int_int_field_1 in
  let d = {
    tuple_int_int_field_0=a + 1;
    tuple_int_int_field_1=b + 1;
  } in
  d

let () =
begin
  let e = {
    tuple_int_int_field_0=0;
    tuple_int_int_field_1=1;
  } in
  let _t = f e in ()
end
 