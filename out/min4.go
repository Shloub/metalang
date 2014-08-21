package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}


func min2(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var h int = 1
  var i int = 2
  var j int = 3
  var k int = 4
  var l int = min2(h, i)
  var m int = min2(min2(l, j), k)
  var g int = m
  fmt.Printf("%d ", g);
  var o int = 1
  var p int = 2
  var q int = 4
  var r int = 3
  var s int = min2(o, p)
  var t int = min2(min2(s, q), r)
  var n int = t
  fmt.Printf("%d ", n);
  var v int = 1
  var w int = 3
  var x int = 2
  var y int = 4
  var z int = min2(v, w)
  var ba int = min2(min2(z, x), y)
  var u int = ba
  fmt.Printf("%d ", u);
  var bc int = 1
  var bd int = 3
  var be int = 4
  var bf int = 2
  var bg int = min2(bc, bd)
  var bh int = min2(min2(bg, be), bf)
  var bb int = bh
  fmt.Printf("%d ", bb);
  var bj int = 1
  var bk int = 4
  var bl int = 2
  var bm int = 3
  var bn int = min2(bj, bk)
  var bo int = min2(min2(bn, bl), bm)
  var bi int = bo
  fmt.Printf("%d ", bi);
  var bq int = 1
  var br int = 4
  var bs int = 3
  var bt int = 2
  var bu int = min2(bq, br)
  var bv int = min2(min2(bu, bs), bt)
  var bp int = bv
  fmt.Printf("%d\n", bp);
  var bx int = 2
  var by int = 1
  var bz int = 3
  var ca int = 4
  var cb int = min2(bx, by)
  var cc int = min2(min2(cb, bz), ca)
  var bw int = cc
  fmt.Printf("%d ", bw);
  var ce int = 2
  var cf int = 1
  var cg int = 4
  var ch int = 3
  var ci int = min2(ce, cf)
  var cj int = min2(min2(ci, cg), ch)
  var cd int = cj
  fmt.Printf("%d ", cd);
  var cl int = 2
  var cm int = 3
  var cn int = 1
  var co int = 4
  var cp int = min2(cl, cm)
  var cq int = min2(min2(cp, cn), co)
  var ck int = cq
  fmt.Printf("%d ", ck);
  var cs int = 2
  var ct int = 3
  var cu int = 4
  var cv int = 1
  var cw int = min2(cs, ct)
  var cx int = min2(min2(cw, cu), cv)
  var cr int = cx
  fmt.Printf("%d ", cr);
  var cz int = 2
  var da int = 4
  var db int = 1
  var dc int = 3
  var dd int = min2(cz, da)
  var de int = min2(min2(dd, db), dc)
  var cy int = de
  fmt.Printf("%d ", cy);
  var dg int = 2
  var dh int = 4
  var di int = 3
  var dj int = 1
  var dk int = min2(dg, dh)
  var dl int = min2(min2(dk, di), dj)
  var df int = dl
  fmt.Printf("%d\n", df);
  var dn int = 3
  var dp int = 1
  var dq int = 2
  var dr int = 4
  var ds int = min2(dn, dp)
  var dt int = min2(min2(ds, dq), dr)
  var dm int = dt
  fmt.Printf("%d ", dm);
  var dv int = 3
  var dw int = 1
  var dx int = 4
  var dy int = 2
  var dz int = min2(dv, dw)
  var ea int = min2(min2(dz, dx), dy)
  var du int = ea
  fmt.Printf("%d ", du);
  var ec int = 3
  var ed int = 2
  var ee int = 1
  var ef int = 4
  var eg int = min2(ec, ed)
  var eh int = min2(min2(eg, ee), ef)
  var eb int = eh
  fmt.Printf("%d ", eb);
  var ej int = 3
  var ek int = 2
  var el int = 4
  var em int = 1
  var en int = min2(ej, ek)
  var eo int = min2(min2(en, el), em)
  var ei int = eo
  fmt.Printf("%d ", ei);
  var eq int = 3
  var er int = 4
  var es int = 1
  var et int = 2
  var eu int = min2(eq, er)
  var ev int = min2(min2(eu, es), et)
  var ep int = ev
  fmt.Printf("%d ", ep);
  var ex int = 3
  var ey int = 4
  var ez int = 2
  var fa int = 1
  var fb int = min2(ex, ey)
  var fc int = min2(min2(fb, ez), fa)
  var ew int = fc
  fmt.Printf("%d\n", ew);
  var fe int = 4
  var ff int = 1
  var fg int = 2
  var fh int = 3
  var fi int = min2(fe, ff)
  var fj int = min2(min2(fi, fg), fh)
  var fd int = fj
  fmt.Printf("%d ", fd);
  var fl int = 4
  var fm int = 1
  var fn int = 3
  var fo int = 2
  var fp int = min2(fl, fm)
  var fq int = min2(min2(fp, fn), fo)
  var fk int = fq
  fmt.Printf("%d ", fk);
  var fs int = 4
  var ft int = 2
  var fu int = 1
  var fv int = 3
  var fw int = min2(fs, ft)
  var fx int = min2(min2(fw, fu), fv)
  var fr int = fx
  fmt.Printf("%d ", fr);
  var fz int = 4
  var ga int = 2
  var gb int = 3
  var gc int = 1
  var gd int = min2(fz, ga)
  var ge int = min2(min2(gd, gb), gc)
  var fy int = ge
  fmt.Printf("%d ", fy);
  var gg int = 4
  var gh int = 3
  var gi int = 1
  var gj int = 2
  var gk int = min2(gg, gh)
  var gl int = min2(min2(gk, gi), gj)
  var gf int = gl
  fmt.Printf("%d ", gf);
  var gn int = 4
  var gp int = 3
  var gq int = 2
  var gr int = 1
  var gs int = min2(gn, gp)
  var gt int = min2(min2(gs, gq), gr)
  var gm int = gt
  fmt.Printf("%d\n", gm);
}

