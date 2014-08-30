package main
import "fmt"
func min2(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func main() {
  var e int = 2
  var f int = 3
  var g int = 4
  fmt.Printf("%d ", min2(min2(e, f), g));
  var i int = 2
  var j int = 4
  var k int = 3
  fmt.Printf("%d ", min2(min2(i, j), k));
  var m int = 3
  var n int = 2
  var o int = 4
  fmt.Printf("%d ", min2(min2(m, n), o));
  var q int = 3
  var r int = 4
  var s int = 2
  fmt.Printf("%d ", min2(min2(q, r), s));
  var u int = 4
  var v int = 2
  var w int = 3
  fmt.Printf("%d ", min2(min2(u, v), w));
  var y int = 4
  var z int = 3
  var ba int = 2
  fmt.Printf("%d\n", min2(min2(y, z), ba));
}

