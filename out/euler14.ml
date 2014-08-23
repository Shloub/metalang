let next_ n =
  if (n mod 2) = 0 then
    n / 2
  else
    3 * n + 1

let rec find n m =
  if n = 1 then
    1
  else if n >= 1000000 then
    1 + find (next_ n) m
  else if m.(n) <> 0 then
    m.(n)
  else
    begin
      m.(n) <- 1 + find (next_ n) m;
      m.(n)
    end

let () =
begin
  let m = Array.init 1000000 (fun _j ->
    0) in
  let max_ = ref( 0 ) in
  let maxi = ref( 0 ) in
  for i = 1 to 999 do
    (* normalement on met 999999 mais ça dépasse les int32... *)
    let n2 = find i m in
    if n2 > (!max_) then
      begin
        max_ := n2;
        maxi := i
      end
  done;
  Printf.printf "%d\n%d\n" (!max_) (!maxi)
end
 