package main
import "fmt"

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func f(tuple_ * tuple_int_int) * tuple_int_int{
  var c * tuple_int_int = tuple_
  var e * tuple_int_int = new (tuple_int_int)
  (*e).tuple_int_int_field_0=(*c).tuple_int_int_field_0 + 1
  (*e).tuple_int_int_field_1=(*c).tuple_int_int_field_1 + 1
  return e
}

func main() {
  var g * tuple_int_int = new (tuple_int_int)
  (*g).tuple_int_int_field_0=0
  (*g).tuple_int_int_field_1=1
  var t * tuple_int_int = f(g)
  var d * tuple_int_int = t
  fmt.Printf("%d -- %d--\n", (*d).tuple_int_int_field_0, (*d).tuple_int_int_field_1);
}

