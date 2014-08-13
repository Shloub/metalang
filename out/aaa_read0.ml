let read_int () =
  Scanf.scanf "%d " (fun x -> x)

let () =
begin
  let len = (read_int ()) in
  Printf.printf "%d\n" len
end
 