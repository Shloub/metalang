package main
import "fmt"

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func f(tuple0 * tuple_int_int) * tuple_int_int{
  var c * tuple_int_int = tuple0
  var a int = (*c).tuple_int_int_field_0
  var b int = (*c).tuple_int_int_field_1
  var d * tuple_int_int = new (tuple_int_int)
  (*d).tuple_int_int_field_0=a + 1
  (*d).tuple_int_int_field_1=b + 1
  return d
}

func main() {
  var e * tuple_int_int = new (tuple_int_int)
  (*e).tuple_int_int_field_0=0
  (*e).tuple_int_int_field_1=1
  var t * tuple_int_int = f(e)
  var g * tuple_int_int = t
  var a int = (*g).tuple_int_int_field_0
  var b int = (*g).tuple_int_int_field_1
  fmt.Printf("%d -- %d--\n", a, b);
}

