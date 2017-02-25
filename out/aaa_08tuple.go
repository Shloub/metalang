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

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

type toto struct {
  foo * tuple_int_int;
  bar int;
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var d int
  var c int
  var bar_ int
  fmt.Fscanf(reader, "%d", &bar_)
  skip()
  fmt.Fscanf(reader, "%d", &c)
  skip()
  fmt.Fscanf(reader, "%d", &d)
  skip()
  var e * tuple_int_int = new (tuple_int_int)
      (*e).tuple_int_int_field_0=c
      (*e).tuple_int_int_field_1=d
  var t * toto = new (toto)
      (*t).foo=e
      (*t).bar=bar_
  var f * tuple_int_int = (*t).foo
  a := (*f).tuple_int_int_field_0
  b := (*f).tuple_int_int_field_1
  fmt.Printf("%d %d %d\n", a, b, (*t).bar)
}

