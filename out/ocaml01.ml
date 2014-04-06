let foo () =
  for _i = 0 to 10 do
     ()
  done;
  0

let bar () =
  for _i = 0 to 10 do
    let _a = 0 in ()
  done;
  0

let () =
begin
   ()
end
 