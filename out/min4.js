
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int_ = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}


function min4_(a, b, c, d){
  return Math.min(a, b, c, d);
}

var f = 1;
var g = 2;
var h = 3;
var i = 4;
var e = Math.min(f, g, h, i);
util.print(e, " ");
var k = 1;
var l = 2;
var m = 4;
var n = 3;
var j = Math.min(k, l, m, n);
util.print(j, " ");
var p = 1;
var q = 3;
var r = 2;
var s = 4;
var o = Math.min(p, q, r, s);
util.print(o, " ");
var u = 1;
var v = 3;
var w = 4;
var x = 2;
var t = Math.min(u, v, w, x);
util.print(t, " ");
var z = 1;
var ba = 4;
var bb = 2;
var bc = 3;
var y = Math.min(z, ba, bb, bc);
util.print(y, " ");
var be = 1;
var bf = 4;
var bg = 3;
var bh = 2;
var bd = Math.min(be, bf, bg, bh);
util.print(bd, "\n");
var bj = 2;
var bk = 1;
var bl = 3;
var bm = 4;
var bi = Math.min(bj, bk, bl, bm);
util.print(bi, " ");
var bo = 2;
var bp = 1;
var bq = 4;
var br = 3;
var bn = Math.min(bo, bp, bq, br);
util.print(bn, " ");
var bt = 2;
var bu = 3;
var bv = 1;
var bw = 4;
var bs = Math.min(bt, bu, bv, bw);
util.print(bs, " ");
var by = 2;
var bz = 3;
var ca = 4;
var cb = 1;
var bx = Math.min(by, bz, ca, cb);
util.print(bx, " ");
var cd = 2;
var ce = 4;
var cf = 1;
var cg = 3;
var cc = Math.min(cd, ce, cf, cg);
util.print(cc, " ");
var ci = 2;
var cj = 4;
var ck = 3;
var cl = 1;
var ch = Math.min(ci, cj, ck, cl);
util.print(ch, "\n");
var cn = 3;
var co = 1;
var cp = 2;
var cq = 4;
var cm = Math.min(cn, co, cp, cq);
util.print(cm, " ");
var cs = 3;
var ct = 1;
var cu = 4;
var cv = 2;
var cr = Math.min(cs, ct, cu, cv);
util.print(cr, " ");
var cx = 3;
var cy = 2;
var cz = 1;
var da = 4;
var cw = Math.min(cx, cy, cz, da);
util.print(cw, " ");
var dc = 3;
var dd = 2;
var de = 4;
var df = 1;
var db = Math.min(dc, dd, de, df);
util.print(db, " ");
var dh = 3;
var di = 4;
var dj = 1;
var dk = 2;
var dg = Math.min(dh, di, dj, dk);
util.print(dg, " ");
var dm = 3;
var dn = 4;
var dp = 2;
var dq = 1;
var dl = Math.min(dm, dn, dp, dq);
util.print(dl, "\n");
var ds = 4;
var dt = 1;
var du = 2;
var dv = 3;
var dr = Math.min(ds, dt, du, dv);
util.print(dr, " ");
var dx = 4;
var dy = 1;
var dz = 3;
var ea = 2;
var dw = Math.min(dx, dy, dz, ea);
util.print(dw, " ");
var ec = 4;
var ed = 2;
var ee = 1;
var ef = 3;
var eb = Math.min(ec, ed, ee, ef);
util.print(eb, " ");
var eh = 4;
var ei = 2;
var ej = 3;
var ek = 1;
var eg = Math.min(eh, ei, ej, ek);
util.print(eg, " ");
var em = 4;
var en = 3;
var eo = 1;
var ep = 2;
var el = Math.min(em, en, eo, ep);
util.print(el, " ");
var er = 4;
var es = 3;
var et = 2;
var eu = 1;
var eq = Math.min(er, es, et, eu);
util.print(eq, "\n");


