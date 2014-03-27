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


type toto struct {
  foo int;
  bar int;
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b * toto = new (toto)
  (*b).foo=0;
  (*b).bar=0;
  var param * toto = b
  fmt.Fscanf(reader, "%d", &(*param).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*param).foo);
  var a int = (*param).bar + (*param).foo * (*param).bar
  fmt.Printf("%d", a);
}

