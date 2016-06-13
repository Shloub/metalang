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
  }else {
      return b
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var y int
  var x int
  fmt.Fscanf(reader, "%d", &x)
  skip()
  fmt.Fscanf(reader, "%d", &y)
  skip()
  var tab [][]int = make([][]int, y)
  for d := 0; d < y; d += 1 {
      var e []int = make([]int, x)
      for f := 0; f < x; f += 1 {
          fmt.Fscanf(reader, "%d", &e[f])
          skip()
      }
      tab[d] = e
  }
  for ix := 1; ix < x; ix += 1 {
      for iy := 1; iy < y; iy += 1 {
          if tab[iy][ix] == 1 {
              tab[iy][ix] = min2_(min2_(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1
          }
      }
  }
  for jy := 0; jy < y; jy += 1 {
      for jx := 0; jx < x; jx += 1 {
          fmt.Printf("%d ", tab[jy][jx])
      }
      fmt.Printf("\n")
  }
}

