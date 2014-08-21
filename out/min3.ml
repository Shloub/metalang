let min2 a b =
  min a b

let () =
begin
  let e = 2 in
  let f = 3 in
  let g = 4 in
  let d = min2 (min2 e f) g in
  Printf.printf "%d " d;
  let i = 2 in
  let j = 4 in
  let k = 3 in
  let h = min2 (min2 i j) k in
  Printf.printf "%d " h;
  let m = 3 in
  let n = 2 in
  let o = 4 in
  let l = min2 (min2 m n) o in
  Printf.printf "%d " l;
  let q = 3 in
  let r = 4 in
  let s = 2 in
  let p = min2 (min2 q r) s in
  Printf.printf "%d " p;
  let u = 4 in
  let v = 2 in
  let w = 3 in
  let t = min2 (min2 u v) w in
  Printf.printf "%d " t;
  let y = 4 in
  let z = 3 in
  let ba = 2 in
  let x = min2 (min2 y z) ba in
  Printf.printf "%d\n" x
end
 