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
  var i int = 1
  var last []int = make([]int, 5)
  for j := 0 ; j < 5; j++ {
    var c byte
    fmt.Fscanf(reader, "%c", &c)
      var d int = (int)(c) - (int)('0')
      i *= d;
      last[j] = d;
  }
  var max0 int = i
  var index int = 0
  var nskipdiv int = 0
  for k := 1 ; k <= 995; k++ {
    var e byte
    fmt.Fscanf(reader, "%c", &e)
      var f int = (int)(e) - (int)('0')
      if f == 0 {
        i = 1;
          nskipdiv = 4;
      } else {
        i *= f;
        if nskipdiv < 0 {
          i /= last[index];
        }
        nskipdiv --;
      }
      last[index] = f;
      index = (index + 1) % 5;
      max0 = max2_(max0, i);
  }
  fmt.Printf("%d\n", max0);
}

