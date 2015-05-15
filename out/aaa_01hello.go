package main
import "fmt"
func main() {
  fmt.Printf("Hello World");
  var a int = 5
  fmt.Printf("%d \n%dfoo", (4 + 6) * 2, a);
  var b bool = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true
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
  fmt.Printf(" ");
  var d bool = (2 == 1) == false
  if d {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1);
  var e bool = !(!(a == 0) && !(a == 4))
  if e {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  var f bool = true && !false && !(true && false)
  if f {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

