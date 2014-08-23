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


func max2(a int, b int) int{
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
  for j := 0 ; j <= 5 - 1; j++ {
    var c byte = '_'
      fmt.Fscanf(reader, "%c", &c);
      var d int = (int)(c) - (int)('0')
      i *= d;
      last[j] = d;
  }
  var max_ int = i
  var index int = 0
  var nskipdiv int = 0
  for k := 1 ; k <= 995; k++ {
    var e byte = '_'
      fmt.Fscanf(reader, "%c", &e);
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
      max_ = max2(max_, i);
  }
  fmt.Printf("%d\n", max_);
}

