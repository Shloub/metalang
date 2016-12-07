let () =
 (*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*)
  let p = Array.init 10 (fun i ->
    i * i * i * i * i) in
  let sum = ref( 0 ) in
  for a = 0 to 9 do
    for b = 0 to 9 do
      for c = 0 to 9 do
        for d = 0 to 9 do
          for e = 0 to 9 do
            for f = 0 to 9 do
              let s = p.(a) + p.(b) + p.(c) + p.(d) + p.(e) + p.(f) in
              let r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000 in
              if s = r && r <> 1 then
                begin
                   Printf.printf "%d%d%d%d%d%d %d\n" f e d c b a r;
                   sum := (!sum) + r
                end
            done
          done
        done
      done
    done
  done;
  Printf.printf "%d" (!sum) 
 