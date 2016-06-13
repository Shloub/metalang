package main
import "fmt"
func main() {
  a := 1
  b := 2
  sum := 0
  for a < 4000000 {
      if a % 2 == 0 {
          sum += a
      }
      c := a
      a = b
      b += c
  }
  fmt.Printf("%d\n", sum)
}

