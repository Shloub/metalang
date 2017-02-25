package main
import "fmt"
func f(i int) bool{
  if i == 0 {
      return true
  }
  return false
}
func main() {
  if f(4) {
      fmt.Printf("true <-\n ->\n")
  } else {
      fmt.Printf("false <-\n ->\n")
  }
  fmt.Printf("small test end\n")
}

