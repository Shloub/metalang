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
  var param * toto = new (toto)
  (*param).foo=0;
  (*param).bar=0;
  fmt.Fscanf(reader, "%d", &(*param).bar)
  skip()
  fmt.Fscanf(reader, "%d", &(*param).foo)
  fmt.Printf("%d", (*param).bar + (*param).foo * (*param).bar);
}

