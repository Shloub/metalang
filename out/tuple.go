package main
import "fmt"

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func f(tuple0 * tuple_int_int) * tuple_int_int{
  var e * tuple_int_int = new (tuple_int_int)
  (*e).tuple_int_int_field_0=(*tuple0).tuple_int_int_field_0 + 1
  (*e).tuple_int_int_field_1=(*tuple0).tuple_int_int_field_1 + 1
  return e
}

func main() {
  var g * tuple_int_int = new (tuple_int_int)
  (*g).tuple_int_int_field_0=0
  (*g).tuple_int_int_field_1=1
  var t * tuple_int_int = f(g)
  fmt.Printf("%d -- %d--\n", (*t).tuple_int_int_field_0, (*t).tuple_int_int_field_1);
}

