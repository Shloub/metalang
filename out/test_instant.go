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



func foo(a int, b int) int{
  return a + b
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  fmt.Printf("%d", 10);
}

