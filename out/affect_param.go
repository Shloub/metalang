package main
import "fmt"
func foo(a int) {
  a = 4
}

func main() {
  a := 0
  foo(a)
  fmt.Printf("%d\n", a)
}

