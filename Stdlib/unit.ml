open Stdlib

(* tests unitaires. *)
let () = begin
  let a = String.replace "o" "\\o" "toto" in
  Format.printf "a=%S\n" a;
  assert (a = "t\\ot\\o");
  assert (List.mapi (fun i a -> a + i) [0 ; 1; 10; 15] = [0; 2; 12; 18] );
end

type ('a, 'b) e =
      Value of 'b
    | Div of 'a * 'a

module E = Fix2 ( struct
  type ('a, 'b) tofix = ('a, 'b) e

  let next =
    let r = ref 0 in
    fun () ->
      let out = !r in
      begin
        r := (out + 1);
        out
      end

  module Make (F:Applicative) = struct
    open F
    let foldmap f g t = match t with
    | Value v -> ret (fun v -> Value v) <*> g v
    | Div (e1, e2) -> ret (fun e1 e2 -> Div (e1, e2)) <*> f e1 <*> f e2
  end
end)

let eval = E.Deep.fold (function
  | Value i -> i
  | Div (e1, e2) -> e1 / e2)

let () =
  let e = eval (E.fix (Div (E.fix (Value 8), (E.fix (Value 2))))) in
  Format.printf "e=%d@\n" e;
  assert (4 = e)
