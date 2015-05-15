let test tab len =
  for i = 0 to len - 1 do
    Printf.printf "%d " tab.(i)
  done;
  Printf.printf "\n"

let () =
begin
  let t = Array.make 5 1 in
  test t 5
end
 