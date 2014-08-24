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


type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func f(tuple_ * tuple_int_int) * tuple_int_int{
  var c * tuple_int_int = tuple_
  var a int = (*c).tuple_int_int_field_0
  var b int = (*c).tuple_int_int_field_1
  var e * tuple_int_int = new (tuple_int_int)
  (*e).tuple_int_int_field_0=a + 1;
  (*e).tuple_int_int_field_1=b + 1;
  return e
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var g * tuple_int_int = new (tuple_int_int)
  (*g).tuple_int_int_field_0=0;
  (*g).tuple_int_int_field_1=1;
  var t * tuple_int_int = f(g)
  var d * tuple_int_int = t
  fmt.Printf("%d -- %d--\n", (*d).tuple_int_int_field_0, (*d).tuple_int_int_field_1);
}

