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

type foo_t = Foo
  | Bar
  | Blah;;
let rec main =
  ((fun foo_val ->
       ()) Foo);;

