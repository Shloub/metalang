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
  for i := 1; i < 4; i++ {
      var b int
      var a int
      fmt.Fscanf(reader, "%d", &a)
      skip()
      fmt.Fscanf(reader, "%d", &b)
      skip()
      fmt.Printf("a = %d b = %d\n", a, b)
  }
  var l []int = make([]int, 10)
  for c := 0; c < 10; c++ {
      fmt.Fscanf(reader, "%d", &l[c])
      skip()
  }
  for j := 0; j < 10; j++ {
      fmt.Printf("%d\n", l[j])
  }
}

