package main
import "fmt"
func main() {
  fmt.Printf("Hello World");
  var a int = 5
  fmt.Printf("%d \n%dfoo", (4 + 6) * 2, a);
  var b bool = 1 + ((1 + 1) * 2 * (3 + 8)) / 4 - (1 - 2) - 3 == 12 && true
  if b {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
  var c bool = (3 * (4 + 5 + 6) * 2 == 45) == false
  if c {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("%d%d", ((4 + 1) / 3) / (2 + 1), ((4 * 1) / 3) / (2 * 1));
  var d bool = !(!(a == 0) && !(a == 4))
  if d {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  var e bool = true && !false && !(true && false)
  if e {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

