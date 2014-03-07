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


func foo(a int) {
  a = 4;
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = 0
  foo(a);
  fmt.Printf("%d\n", a);
}

