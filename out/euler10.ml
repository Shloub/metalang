let eratostene t max_ =
  let sum = ref( 0 ) in
  for i = 2 to max_ - 1 do
    if t.(i) = i then
      begin
        sum := (!sum) + i;
        let j = ref( i * i ) in
        (*
			detect overflow
			*)
        if (!j) / i = i then
          while (!j) < max_ && (!j) > 0
          do
              t.((!j)) <- 0;
              j := (!j) + i
          done
      end
  done;
  (!sum)

let () =
begin
  let n = 100000 in
  (* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages *)
  let t = Array.init n (fun i ->
    i) in
  t.(1) <- 0;
  Printf.printf "%d\n" (eratostene t n)
end
 