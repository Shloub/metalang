package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func max2_(a int, b int) int{
  if a > b {
      return a
  } else {
      return b
  }
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  i := 1
  var last []int = make([]int, 5)
  for j := 0; j < 5; j++ {
      var c byte
      fmt.Fscanf(reader, "%c", &c)
      d := (int)(c) - (int)('0')
      i *= d
      last[j] = d
  }
  max0 := i
  index := 0
  nskipdiv := 0
  for k := 1; k < 996; k++ {
      var e byte
      fmt.Fscanf(reader, "%c", &e)
      f := (int)(e) - (int)('0')
      if f == 0 {
          i = 1
          nskipdiv = 4
      } else {
          i *= f
          if nskipdiv < 0 {
              i /= last[index]
          }
          nskipdiv--
      }
      last[index] = f
      index = (index + 1) % 5
      max0 = max2_(max0, i)
  }
  fmt.Printf("%d\n", max0)
}

