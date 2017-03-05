exception Found_1 of bool

let is_pair i =
  try
  let _j = ref( 1 ) in
  if i < 10 then
    begin
       _j := 2;
       if i = 0 then
         begin
            _j := 4;
            raise (Found_1(true))
         end;
       _j := 3;
       if i = 2 then
         begin
            _j := 4;
            raise (Found_1(true))
         end;
       _j := 5
    end;
  _j := 6;
  if i < 20 then
    begin
       if i = 22 then
         _j := 0;
       _j := 8
    end;
  i mod 2 = 0
  with Found_1 (out) -> out

let () =
 
  () 
 