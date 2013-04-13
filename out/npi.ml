
let rec is_number c =
  ((int_of_char (c)) <= (int_of_char ('9'))) && ((int_of_char (c)) >= (int_of_char ('0')))

(*
Notation polonaise inversée
*)
let rec npi_ str len =
  let stack = Array.init (len) (fun i ->
    0) in
  let ptrStack = ref( 0 ) in
  let ptrStr = ref( 0 ) in
  while (!ptrStr) < len
  do
      if str.((!ptrStr)) = (' ') then
        ptrStr := (!ptrStr) + 1
      else if is_number str.((!ptrStr)) then
        begin
          let num = ref( 0 ) in
          while str.((!ptrStr)) <> (' ')
          do
              num := (((!num) * 10) + (int_of_char (str.((!ptrStr))))) - (int_of_char ('0'));
              ptrStr := (!ptrStr) + 1
          done;
          stack.((!ptrStack)) <- (!num);
          ptrStack := (!ptrStack) + 1
        end
      else if str.((!ptrStr)) = ('+') then
        begin
          stack.((!ptrStack) - 2) <- stack.((!ptrStack) - 2) + stack.((!ptrStack) - 1);
          ptrStack := (!ptrStack) - 1;
          ptrStr := (!ptrStr) + 1
        end
  done;
  stack.(0)

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let tmp = ref( '\000' ) in
    Scanf.scanf "%c" (fun value -> tmp := value);
    (!tmp)) in
  let result = npi_ tab (!len) in
  Printf.printf "%d" (result)
end
 