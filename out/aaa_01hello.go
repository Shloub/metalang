package main
import "fmt"
func main() {
  fmt.Printf("Hello World")
  a := 5
  fmt.Printf("%d \n%dfoo", (4 + 6) * 2, a)
  if 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 == 12 && true {
      fmt.Printf("True")
  } else {
      fmt.Printf("False")
  }
  fmt.Printf("\n")
  if (3 * (4 + 5 + 6) * 2 == 45) == false {
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
  fmt.Printf(" %d%d", (4 + 1) / 3 / (2 + 1), 4 * 1 / 3 / 2 * 1)
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

