package main
type foo_t int
const (
  Foo foo_t = iota
  Bar foo_t = iota
  Blah foo_t = iota);
func main() {
  var foo_val foo_t = Foo
  _  = foo_val
}

