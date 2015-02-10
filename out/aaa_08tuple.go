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
  var bar_ int
  fmt.Fscanf(reader, "%d", &bar_)
  skip()
  var f int
  fmt.Fscanf(reader, "%d", &f)
  skip()
  var g int
  fmt.Fscanf(reader, "%d", &g)
  skip()
  var i * tuple_int_int = new (tuple_int_int)
  (*i).tuple_int_int_field_0=f
  (*i).tuple_int_int_field_1=g
  var t * toto = new (toto)
  (*t).foo=i
  (*t).bar=bar_
  var h * tuple_int_int = (*t).foo
  var a int = (*h).tuple_int_int_field_0
  var b int = (*h).tuple_int_int_field_1
  fmt.Printf("%d %d %d\n", a, b, (*t).bar);
}

