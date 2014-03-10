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
  var t_ * toto = new (toto)
  (*t_).foo=v1;
  (*t_).bar=0;
  (*t_).blah=0;
  return t_
}

func result(t_ * toto) int{
  (*t_).blah ++;
  return (*t_).foo + (*t_).blah * (*t_).bar + (*t_).bar * (*t_).foo
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var t_ * toto = mktoto(4)
  fmt.Fscanf(reader, "%d", &(*t_).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*t_).blah);
  var a int = result(t_)
  fmt.Printf("%d", a);
  var b int = (*t_).blah
  fmt.Printf("%d", b);
}

