package main
import "fmt"

type foo struct {
  a int;
  b *int;
  c []int;
  d []*int;
  e []int;
  f * foo;
  g []* foo;
  h []* foo;
}
func default0(a *int, b * foo, c []*int, d []* foo, e []int, f []* foo) int{
  return 0
}
func aa(b * foo) {
  
}
func main() {
  fmt.Printf("___\n")
}

