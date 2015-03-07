exception Found_1 of int

let nbPassePartout n passepartout m serrures =
  try
  let max_ancient = ref( 0 ) in
  let max_recent = ref( 0 ) in
  for i = 0 to m - 1 do
    if serrures.(i).(0) = -1 && serrures.(i).(1) > (!max_ancient) then
      max_ancient := serrures.(i).(1);
    if serrures.(i).(0) = 1 && serrures.(i).(1) > (!max_recent) then
      max_recent := serrures.(i).(1)
  done;
  let max_ancient_pp = ref( 0 ) in
  let max_recent_pp = ref( 0 ) in
  for i = 0 to n - 1 do
    let pp = passepartout.(i) in
    if pp.(0) >= (!max_ancient) && pp.(1) >= (!max_recent) then
      raise (Found_1(1));
    max_ancient_pp := (max ((!max_ancient_pp)) (pp.(0)));
    max_recent_pp := (max ((!max_recent_pp)) (pp.(1)))
  done;
  if (!max_ancient_pp) >= (!max_ancient) && (!max_recent_pp) >= (!max_recent) then
    2
  else
    0
  with Found_1 (out) -> out

let () =
begin
  let n = Scanf.scanf "%d " (fun v_0 -> v_0) in
  let passepartout = Array.init n (fun _i ->
    let out0 = Array.init 2 (fun _j ->
      let out01 = Scanf.scanf "%d " (fun v_0 -> v_0) in
      out01) in
    out0) in
  let m = Scanf.scanf "%d " (fun v_0 -> v_0) in
  let serrures = Array.init m (fun _k ->
    let out1 = Array.init 2 (fun _l ->
      let out_ = Scanf.scanf "%d " (fun v_0 -> v_0) in
      out_) in
    out1) in
  Printf.printf "%d" (nbPassePartout n passepartout m serrures)
end
 