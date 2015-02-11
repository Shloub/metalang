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
  var len int
  fmt.Fscanf(reader, "%d", &len)
  skip()
  fmt.Printf("%d=len\n", len);
  var tab1 []int = make([]int, len)
  for a := 0 ; a <= len - 1; a++ {
    fmt.Fscanf(reader, "%d", &tab1[a])
      skip()
  }
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d\n", i, tab1[i]);
  }
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab2 [][]int = make([][]int, (len - 1))
  for b := 0 ; b <= len - 1 - 1; b++ {
    var c []int = make([]int, len)
      for d := 0 ; d <= len - 1; d++ {
        fmt.Fscanf(reader, "%d", &c[d])
          skip()
      }
      tab2[b] = c;
  }
  for i := 0 ; i <= len - 2; i++ {
    for j := 0 ; j <= len - 1; j++ {
        fmt.Printf("%d ", tab2[i][j]);
      }
      fmt.Printf("\n");
  }
}

