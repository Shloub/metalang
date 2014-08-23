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
  fmt.Printf("%d ", min2(min2(l, j), k));
  var o int = 1
  var p int = 2
  var q int = 4
  _ = q
  var r int = 3
  _ = r
  var s int = min2(o, p)
  _ = s
  fmt.Printf("%d ", min2(min2(l, j), k));
  var v int = 1
  var w int = 3
  var x int = 2
  _ = x
  var y int = 4
  _ = y
  var z int = min2(v, w)
  _ = z
  fmt.Printf("%d ", min2(min2(l, j), k));
  var bc int = 1
  var bd int = 3
  var be int = 4
  _ = be
  var bf int = 2
  _ = bf
  var bg int = min2(bc, bd)
  _ = bg
  fmt.Printf("%d ", min2(min2(l, j), k));
  var bj int = 1
  var bk int = 4
  var bl int = 2
  _ = bl
  var bm int = 3
  _ = bm
  var bn int = min2(bj, bk)
  _ = bn
  fmt.Printf("%d ", min2(min2(l, j), k));
  var bq int = 1
  var br int = 4
  var bs int = 3
  _ = bs
  var bt int = 2
  _ = bt
  var bu int = min2(bq, br)
  _ = bu
  fmt.Printf("%d\n", min2(min2(l, j), k));
  var bx int = 2
  var by int = 1
  var bz int = 3
  _ = bz
  var ca int = 4
  _ = ca
  var cb int = min2(bx, by)
  _ = cb
  fmt.Printf("%d ", min2(min2(l, j), k));
  var ce int = 2
  var cf int = 1
  var cg int = 4
  _ = cg
  var ch int = 3
  _ = ch
  var ci int = min2(ce, cf)
  _ = ci
  fmt.Printf("%d ", min2(min2(l, j), k));
  var cl int = 2
  var cm int = 3
  var cn int = 1
  _ = cn
  var co int = 4
  _ = co
  var cp int = min2(cl, cm)
  _ = cp
  fmt.Printf("%d ", min2(min2(l, j), k));
  var cs int = 2
  var ct int = 3
  var cu int = 4
  _ = cu
  var cv int = 1
  _ = cv
  var cw int = min2(cs, ct)
  _ = cw
  fmt.Printf("%d ", min2(min2(l, j), k));
  var cz int = 2
  var da int = 4
  var db int = 1
  _ = db
  var dc int = 3
  _ = dc
  var dd int = min2(cz, da)
  _ = dd
  fmt.Printf("%d ", min2(min2(l, j), k));
  var dg int = 2
  var dh int = 4
  var di int = 3
  _ = di
  var dj int = 1
  _ = dj
  var dk int = min2(dg, dh)
  _ = dk
  fmt.Printf("%d\n", min2(min2(l, j), k));
  var dn int = 3
  var dp int = 1
  var dq int = 2
  _ = dq
  var dr int = 4
  _ = dr
  var ds int = min2(dn, dp)
  _ = ds
  fmt.Printf("%d ", min2(min2(l, j), k));
  var dv int = 3
  var dw int = 1
  var dx int = 4
  _ = dx
  var dy int = 2
  _ = dy
  var dz int = min2(dv, dw)
  _ = dz
  fmt.Printf("%d ", min2(min2(l, j), k));
  var ec int = 3
  var ed int = 2
  var ee int = 1
  _ = ee
  var ef int = 4
  _ = ef
  var eg int = min2(ec, ed)
  _ = eg
  fmt.Printf("%d ", min2(min2(l, j), k));
  var ej int = 3
  var ek int = 2
  var el int = 4
  _ = el
  var em int = 1
  _ = em
  var en int = min2(ej, ek)
  _ = en
  fmt.Printf("%d ", min2(min2(l, j), k));
  var eq int = 3
  var er int = 4
  var es int = 1
  _ = es
  var et int = 2
  _ = et
  var eu int = min2(eq, er)
  _ = eu
  fmt.Printf("%d ", min2(min2(l, j), k));
  var ex int = 3
  var ey int = 4
  var ez int = 2
  _ = ez
  var fa int = 1
  _ = fa
  var fb int = min2(ex, ey)
  _ = fb
  fmt.Printf("%d\n", min2(min2(l, j), k));
  var fe int = 4
  var ff int = 1
  var fg int = 2
  _ = fg
  var fh int = 3
  _ = fh
  var fi int = min2(fe, ff)
  _ = fi
  fmt.Printf("%d ", min2(min2(l, j), k));
  var fl int = 4
  var fm int = 1
  var fn int = 3
  _ = fn
  var fo int = 2
  _ = fo
  var fp int = min2(fl, fm)
  _ = fp
  fmt.Printf("%d ", min2(min2(l, j), k));
  var fs int = 4
  var ft int = 2
  var fu int = 1
  _ = fu
  var fv int = 3
  _ = fv
  var fw int = min2(fs, ft)
  _ = fw
  fmt.Printf("%d ", min2(min2(l, j), k));
  var fz int = 4
  var ga int = 2
  var gb int = 3
  _ = gb
  var gc int = 1
  _ = gc
  var gd int = min2(fz, ga)
  _ = gd
  fmt.Printf("%d ", min2(min2(l, j), k));
  var gg int = 4
  var gh int = 3
  var gi int = 1
  _ = gi
  var gj int = 2
  _ = gj
  var gk int = min2(gg, gh)
  _ = gk
  fmt.Printf("%d ", min2(min2(l, j), k));
  var gn int = 4
  var gp int = 3
  var gq int = 2
  _ = gq
  var gr int = 1
  _ = gr
  var gs int = min2(gn, gp)
  _ = gs
  fmt.Printf("%d\n", min2(min2(l, j), k));
}

