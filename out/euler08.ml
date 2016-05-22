let () =
begin
  let i = ref( 1 ) in
  let last = Array.init 5 (fun _j ->
    let c = Scanf.scanf "%c" (fun c -> c) in
    let d = int_of_char (c) - int_of_char ('0') in
    i := (!i) * d;
    d) in
  let max0 = ref( (!i) ) in
  let index = ref( 0 ) in
  let nskipdiv = ref( 0 ) in
  for _k = 1 to 995 do
    let e = Scanf.scanf "%c" (fun e -> e) in
    let f = int_of_char (e) - int_of_char ('0') in
    if f = 0 then
      begin
        i := 1;
        nskipdiv := 4
      end
    else
      begin
        i := (!i) * f;
        if (!nskipdiv) < 0 then
          i := (!i) / last.((!index));
        nskipdiv := (!nskipdiv) - 1
      end;
    last.((!index)) <- f;
    index := ((!index) + 1) mod 5;
    max0 := max ((!max0)) ((!i))
  done;
  Printf.printf "%d\n" (!max0)
end
 