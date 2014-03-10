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

func result(t_ []* toto, len int) int{
  var out_ int = 0
  for j := 0 ; j <= len - 1; j++ {
    (*t_[j]).blah = (*t_[j]).blah + 1;
      out_ = out_ + (*t_[j]).foo + (*t_[j]).blah * (*t_[j]).bar + (*t_[j]).bar * (*t_[j]).foo;
  }
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = 4
  var t_ []* toto = make([]* toto, a)
  for i := 0 ; i <= a - 1; i++ {
    t_[i] = mktoto(i);
  }
  fmt.Fscanf(reader, "%d", &(*t_[0]).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*t_[1]).blah);
  var b int = result(t_, 4)
  fmt.Printf("%d", b);
  var c int = (*t_[2]).blah
  fmt.Printf("%d", c);
}

