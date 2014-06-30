
let () =
begin
  let _maximum = 1 in
  let b0 = ref( 2 ) in
  let a = ref( 408464633 ) in
  while (!a) <> 1
  do
      let b = ref( (!b0) ) in
      let found = ref( false ) in
      while (!b) * (!b) < (!a)
      do
          if ((!a) mod (!b)) = 0 then
            begin
              a := (!a) / (!b);
              b0 := (!b);
              b := (!a);
              found := true
            end;
          b := (!b) + 1
      done;
      if not (!found) then
        begin
          Printf.printf "%d\n" (!a);
          a := 1
        end
  done
end
 