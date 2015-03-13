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
func min2_(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var x int
  fmt.Fscanf(reader, "%d", &x)
  skip()
  var y int
  fmt.Fscanf(reader, "%d", &y)
  skip()
  var tab [][]int = make([][]int, y)
  for d := 0 ; d <= y - 1; d++ {
    var e []int = make([]int, x)
      for f := 0 ; f <= x - 1; f++ {
        fmt.Fscanf(reader, "%d", &e[f])
          skip()
      }
      tab[d] = e;
  }
  for ix := 1 ; ix <= x - 1; ix++ {
    for iy := 1 ; iy <= y - 1; iy++ {
        if tab[iy][ix] == 1 {
            tab[iy][ix] = min2_(min2_(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
          }
      }
  }
  for jy := 0 ; jy <= y - 1; jy++ {
    for jx := 0 ; jx <= x - 1; jx++ {
        fmt.Printf("%d ", tab[jy][jx]);
      }
      fmt.Printf("\n");
  }
}

