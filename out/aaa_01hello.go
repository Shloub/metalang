package main
import "fmt"
func main() {
  fmt.Printf("Hello World")
  a := 5
  fmt.Printf("%d \n%dfoo", (4 + 6) * 2, a)
  if 1 + 2 * 2 * (3 + 8) / 4 - 2 == 12 && true {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  fmt.Printf("\n")
  if (3 * (4 + 11) * 2 == 45) == false {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  fmt.Printf(" ")
  if (2 == 1) == false {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  fmt.Printf(" %d%d", 5 / 3 / 3, 4 * 1 / 3 / 2 * 1)
  if !(!(a == 0) && !(a == 4)) {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  if true && !false && !(true && false) {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  fmt.Printf("\n")
}

