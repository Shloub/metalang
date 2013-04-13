let rec max2 a b =
  if a > b then
    a
  else
    b

exception Found_1 of int;;
let rec nbPassePartout n passepartout m serrures =
  try
  let max_ancient = ref( 0 ) in
  let max_recent = ref( 0 ) in
  for i = 0 to m - 1 do
    if (serrures.(i).(0) = -1) && (serrures.(i).(1) > (!max_ancient)) then
      max_ancient := serrures.(i).(1);
    if (serrures.(i).(0) = 1) && (serrures.(i).(1) > (!max_recent)) then
      max_recent := serrures.(i).(1)
  done;
  let max_ancient_pp = ref( 0 ) in
  let max_recent_pp = ref( 0 ) in
  for i = 0 to n - 1 do
    let pp = passepartout.(i) in
    if (pp.(0) >= (!max_ancient)) && (pp.(1) >= (!max_recent)) then
      raise (Found_1(1));
    max_ancient_pp := max2 (!max_ancient_pp) pp.(0);
    max_recent_pp := max2 (!max_recent_pp) pp.(1)
  done;
  if ((!max_ancient_pp) >= (!max_ancient)) && ((!max_recent_pp) >= (!max_recent)) then
    raise (Found_1(2))
  else
    raise (Found_1(0))
  with Found_1(out) -> out

let () =
begin
  let n = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let passepartout = Array.init (n) (fun i ->
    let ba = 2 in
    let out0 = Array.init (ba) (fun j ->
      let out_ = Scanf.scanf "%d" (fun x -> x) in
      Scanf.scanf "%[\n \010]" (fun _ -> ());
      out_) in
    out0) in
  let m = Scanf.scanf "%d" (fun x -> x) in
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let serrures = Array.init (m) (fun i ->
    let bb = 2 in
    let out0 = Array.init (bb) (fun j ->
      let out_ = Scanf.scanf "%d" (fun x -> x) in
      Scanf.scanf "%[\n \010]" (fun _ -> ());
      out_) in
    out0) in
  let bc = nbPassePartout n passepartout m serrures in
  Printf.printf "%d" (bc)
end
 