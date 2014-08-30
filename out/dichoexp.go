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

func exp_(a int, b int) int{
  if b == 0 {
    return 1
  }
  if (b % 2) == 0 {
    var o int = exp_(a, b / 2)
      return o * o
  } else {
    return a * exp_(a, b - 1)
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = 0
  var b int = 0
  fmt.Fscanf(reader, "%d", &a)
  skip()
  fmt.Fscanf(reader, "%d", &b)
  fmt.Printf("%d", exp_(a, b));
}

