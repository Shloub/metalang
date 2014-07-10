let min2 a b =
  min a b

let min3 a b c =
  min2 (min2 a b) c

let min4_ a b c d =
  let f = min2 a b in
  let e = min2 (min2 f c) d in
  e

let () =
begin
  let h = 1 in
  let i = 2 in
  let j = 3 in
  let k = 4 in
  let l = min2 h i in
  let m = min2 (min2 l j) k in
  let g = m in
  Printf.printf "%d " g;
  let o = 1 in
  let p = 2 in
  let q = 4 in
  let r = 3 in
  let s = min2 o p in
  let t = min2 (min2 s q) r in
  let n = t in
  Printf.printf "%d " n;
  let v = 1 in
  let w = 3 in
  let x = 2 in
  let y = 4 in
  let z = min2 v w in
  let ba = min2 (min2 z x) y in
  let u = ba in
  Printf.printf "%d " u;
  let bc = 1 in
  let bd = 3 in
  let be = 4 in
  let bf = 2 in
  let bg = min2 bc bd in
  let bh = min2 (min2 bg be) bf in
  let bb = bh in
  Printf.printf "%d " bb;
  let bj = 1 in
  let bk = 4 in
  let bl = 2 in
  let bm = 3 in
  let bn = min2 bj bk in
  let bo = min2 (min2 bn bl) bm in
  let bi = bo in
  Printf.printf "%d " bi;
  let bq = 1 in
  let br = 4 in
  let bs = 3 in
  let bt = 2 in
  let bu = min2 bq br in
  let bv = min2 (min2 bu bs) bt in
  let bp = bv in
  Printf.printf "%d\n" bp;
  let bx = 2 in
  let by = 1 in
  let bz = 3 in
  let ca = 4 in
  let cb = min2 bx by in
  let cc = min2 (min2 cb bz) ca in
  let bw = cc in
  Printf.printf "%d " bw;
  let ce = 2 in
  let cf = 1 in
  let cg = 4 in
  let ch = 3 in
  let ci = min2 ce cf in
  let cj = min2 (min2 ci cg) ch in
  let cd = cj in
  Printf.printf "%d " cd;
  let cl = 2 in
  let cm = 3 in
  let cn = 1 in
  let co = 4 in
  let cp = min2 cl cm in
  let cq = min2 (min2 cp cn) co in
  let ck = cq in
  Printf.printf "%d " ck;
  let cs = 2 in
  let ct = 3 in
  let cu = 4 in
  let cv = 1 in
  let cw = min2 cs ct in
  let cx = min2 (min2 cw cu) cv in
  let cr = cx in
  Printf.printf "%d " cr;
  let cz = 2 in
  let da = 4 in
  let db = 1 in
  let dc = 3 in
  let dd = min2 cz da in
  let de = min2 (min2 dd db) dc in
  let cy = de in
  Printf.printf "%d " cy;
  let dg = 2 in
  let dh = 4 in
  let di = 3 in
  let dj = 1 in
  let dk = min2 dg dh in
  let dl = min2 (min2 dk di) dj in
  let df = dl in
  Printf.printf "%d\n" df;
  let dn = 3 in
  let dp = 1 in
  let dq = 2 in
  let dr = 4 in
  let ds = min2 dn dp in
  let dt = min2 (min2 ds dq) dr in
  let dm = dt in
  Printf.printf "%d " dm;
  let dv = 3 in
  let dw = 1 in
  let dx = 4 in
  let dy = 2 in
  let dz = min2 dv dw in
  let ea = min2 (min2 dz dx) dy in
  let du = ea in
  Printf.printf "%d " du;
  let ec = 3 in
  let ed = 2 in
  let ee = 1 in
  let ef = 4 in
  let eg = min2 ec ed in
  let eh = min2 (min2 eg ee) ef in
  let eb = eh in
  Printf.printf "%d " eb;
  let ej = 3 in
  let ek = 2 in
  let el = 4 in
  let em = 1 in
  let en = min2 ej ek in
  let eo = min2 (min2 en el) em in
  let ei = eo in
  Printf.printf "%d " ei;
  let eq = 3 in
  let er = 4 in
  let es = 1 in
  let et = 2 in
  let eu = min2 eq er in
  let ev = min2 (min2 eu es) et in
  let ep = ev in
  Printf.printf "%d " ep;
  let ex = 3 in
  let ey = 4 in
  let ez = 2 in
  let fa = 1 in
  let fb = min2 ex ey in
  let fc = min2 (min2 fb ez) fa in
  let ew = fc in
  Printf.printf "%d\n" ew;
  let fe = 4 in
  let ff = 1 in
  let fg = 2 in
  let fh = 3 in
  let fi = min2 fe ff in
  let fj = min2 (min2 fi fg) fh in
  let fd = fj in
  Printf.printf "%d " fd;
  let fl = 4 in
  let fm = 1 in
  let fn = 3 in
  let fo = 2 in
  let fp = min2 fl fm in
  let fq = min2 (min2 fp fn) fo in
  let fk = fq in
  Printf.printf "%d " fk;
  let fs = 4 in
  let ft = 2 in
  let fu = 1 in
  let fv = 3 in
  let fw = min2 fs ft in
  let fx = min2 (min2 fw fu) fv in
  let fr = fx in
  Printf.printf "%d " fr;
  let fz = 4 in
  let ga = 2 in
  let gb = 3 in
  let gc = 1 in
  let gd = min2 fz ga in
  let ge = min2 (min2 gd gb) gc in
  let fy = ge in
  Printf.printf "%d " fy;
  let gg = 4 in
  let gh = 3 in
  let gi = 1 in
  let gj = 2 in
  let gk = min2 gg gh in
  let gl = min2 (min2 gk gi) gj in
  let gf = gl in
  Printf.printf "%d " gf;
  let gn = 4 in
  let gp = 3 in
  let gq = 2 in
  let gr = 1 in
  let gs = min2 gn gp in
  let gt = min2 (min2 gs gq) gr in
  let gm = gt in
  Printf.printf "%d\n" gm
end
 