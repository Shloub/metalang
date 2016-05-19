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

type toto struct {
  foo int;
  bar int;
  blah int;
}

func mktoto(v1 int) * toto{
  var t * toto = new (toto)
  (*t).foo=v1
  (*t).bar=0
  (*t).blah=0
  return t
}

func result(t * toto) int{
  (*t).blah++;
  return (*t).foo + (*t).blah * (*t).bar + (*t).bar * (*t).foo
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var t * toto = mktoto(4)
  fmt.Fscanf(reader, "%d", &(*t).bar)
  skip()
  fmt.Fscanf(reader, "%d", &(*t).blah)
  fmt.Printf("%d", result(t));
}

