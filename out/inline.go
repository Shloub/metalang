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


func foo(i int) {
  fmt.Printf("%d\n", i);
}

func foobar(i int) {
  fmt.Printf("%d\nfoobar", i);
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = 0
  fmt.Printf("%d\n", a);
  var b int = 12
  fmt.Printf("%d\nfoobar", b);
  var c int = 1
  fmt.Printf("%d\n", c);
}

