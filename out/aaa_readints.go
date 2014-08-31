package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var f int
  fmt.Fscanf(reader, "%d", &f)
  skip()
  var len int = f
  fmt.Printf("%d=len\n", len);
  var h []int = make([]int, len)
  for k := 0 ; k <= len - 1; k++ {
    fmt.Fscanf(reader, "%d", &h[k])
      skip()
  }
  var tab1 []int = h
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d\n", i, tab1[i]);
  }
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var r [][]int = make([][]int, (len - 1))
  for s := 0 ; s <= len - 1 - 1; s++ {
    var u []int = make([]int, len)
      for v := 0 ; v <= len - 1; v++ {
        var w int
        fmt.Fscanf(reader, "%d", &w)
          skip()
          u[v] = w;
      }
      r[s] = u;
  }
  var tab2 [][]int = r
  for i := 0 ; i <= len - 2; i++ {
    for j := 0 ; j <= len - 1; j++ {
        fmt.Printf("%d ", tab2[i][j]);
      }
      fmt.Printf("\n");
  }
}

