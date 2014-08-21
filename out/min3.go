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
  var e int = 2
  var f int = 3
  var g int = 4
  var d int = min2(min2(e, f), g)
  fmt.Printf("%d ", d);
  var i int = 2
  var j int = 4
  var k int = 3
  var h int = min2(min2(i, j), k)
  fmt.Printf("%d ", h);
  var m int = 3
  var n int = 2
  var o int = 4
  var l int = min2(min2(m, n), o)
  fmt.Printf("%d ", l);
  var q int = 3
  var r int = 4
  var s int = 2
  var p int = min2(min2(q, r), s)
  fmt.Printf("%d ", p);
  var u int = 4
  var v int = 2
  var w int = 3
  var t int = min2(min2(u, v), w)
  fmt.Printf("%d ", t);
  var y int = 4
  var z int = 3
  var ba int = 2
  var x int = min2(min2(y, z), ba)
  fmt.Printf("%d\n", x);
}

