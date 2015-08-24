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
  for i := 1 ; i <= 3; i++ {
    var a int
    fmt.Fscanf(reader, "%d", &a)
      skip()
      var b int
      fmt.Fscanf(reader, "%d", &b)
      skip()
      var c int
      fmt.Fscanf(reader, "%d", &c)
      skip()
      fmt.Printf("a = %d b = %dc =%d\n", a, b, c);
  }
  var l []int = make([]int, 10)
  for d := 0 ; d < 10; d++ {
    fmt.Fscanf(reader, "%d", &l[d])
      skip()
  }
  for j := 0 ; j <= 9; j++ {
    fmt.Printf("%d\n", l[j]);
  }
}

