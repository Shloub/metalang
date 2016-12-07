exception Found_1 of bool

let is_pair i =
  try
  let j = ref( 1 ) in
  if i < 10 then
    begin
       j := 2;
       if i = 0 then
         begin
            j := 4;
            raise (Found_1(true))
         end;
       j := 3;
       if i = 2 then
         begin
            j := 4;
            raise (Found_1(true))
         end;
       j := 5
    end;
  j := 6;
  if i < 20 then
    begin
       if i = 22 then
         j := 0;
       j := 8
    end;
  i mod 2 = 0
  with Found_1 (out) -> out

let () =
 
  () 
 