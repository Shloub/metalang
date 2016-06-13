package main
import "fmt"
func min2_(a int, b int) int{
  if a < b {
      return a
  } else {
      return b
  }
}

func main() {
  fmt.Printf("%d %d %d %d %d %d\n", min2_(min2_(2, 3), 4), min2_(min2_(2, 4), 3), min2_(min2_(3, 2), 4), min2_(min2_(3, 4), 2), min2_(min2_(4, 2), 3), min2_(min2_(4, 3), 2))
}

