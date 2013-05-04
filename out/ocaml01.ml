let rec foo () =
  for i = 0 to 10 do
     ()
  done;
  0

let rec bar () =
  for i = 0 to 10 do
    let a = 0 in ()
  done;
  0

let () =
begin
   ()
end
 