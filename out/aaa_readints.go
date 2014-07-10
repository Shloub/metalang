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


func read_int() int{
  var out_ int = 0
  fmt.Fscanf(reader, "%d", &out_);
  skip()
  return out_
}

func read_int_line(n int) []int{
  var tab []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var t int = 0
      fmt.Fscanf(reader, "%d", &t);
      skip()
      tab[i] = t;
  }
  return tab
}

func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    var b int = x
      var c []int = make([]int, b)
      for d := 0 ; d <= b - 1; d++ {
        var e int = 0
          fmt.Fscanf(reader, "%d", &e);
          skip()
          c[d] = e;
      }
      var a []int = c
      tab[z] = a;
  }
  return tab
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var g int = 0
  fmt.Fscanf(reader, "%d", &g);
  skip()
  var f int = g
  var len int = f
  fmt.Printf("%d=len\n", len);
  var k int = len
  var l []int = make([]int, k)
  for m := 0 ; m <= k - 1; m++ {
    var o int = 0
      fmt.Fscanf(reader, "%d", &o);
      skip()
      l[m] = o;
  }
  var h []int = l
  var tab1 []int = h
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d\n", i, tab1[i]);
  }
  var q int = 0
  fmt.Fscanf(reader, "%d", &q);
  skip()
  var p int = q
  len = p;
  var tab2 [][]int = read_int_matrix(len, len - 1)
  for i := 0 ; i <= len - 2; i++ {
    for j := 0 ; j <= len - 1; j++ {
        fmt.Printf("%d ", tab2[i][j]);
      }
      fmt.Printf("\n");
  }
}

