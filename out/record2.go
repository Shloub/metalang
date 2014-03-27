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
  blah int;
}

func mktoto(v1 int) * toto{
  var c * toto = new (toto)
  (*c).foo=v1;
  (*c).bar=0;
  (*c).blah=0;
  var t * toto = c
  return t
}

func result(t * toto) int{
  (*t).blah ++;
  return (*t).foo + (*t).blah * (*t).bar + (*t).bar * (*t).foo
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var t * toto = mktoto(4)
  fmt.Fscanf(reader, "%d", &(*t).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*t).blah);
  var a int = result(t)
  fmt.Printf("%d", a);
  var b int = (*t).blah
  fmt.Printf("%d", b);
}

