let () =
 let f = Array.init 10 (fun _j ->
   1) in
  for i = 1 to 9 do
    f.(i) <- f.(i) * i * f.(i - 1);
    Printf.printf "%d " f.(i)
  done;
  let out0 = ref( 0 ) in
  Printf.printf "\n";
  for a = 0 to 9 do
    for b = 0 to 9 do
      for c = 0 to 9 do
        for d = 0 to 9 do
          for e = 0 to 9 do
            for g = 0 to 9 do
              let sum = ref( f.(a) + f.(b) + f.(c) + f.(d) + f.(e) + f.(g) ) in
              let num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g in
              if a = 0 then
                begin
                   sum := (!sum) - 1;
                   if b = 0 then
                     begin
                        sum := (!sum) - 1;
                        if c = 0 then
                          begin
                             sum := (!sum) - 1;
                             if d = 0 then
                               sum := (!sum) - 1
                          end
                     end
                end;
              if (!sum) = num && (!sum) <> 1 && (!sum) <> 2 then
                begin
                   out0 := (!out0) + num;
                   Printf.printf "%d " num
                end
            done
          done
        done
      done
    done
  done;
  Printf.printf "\n%d\n" (!out0) 
 