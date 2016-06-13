package main
import "fmt"
import "math"
func main() {
  maximum := 1
  _ = maximum
  b0 := 2
  a := 408464633
  sqrtia := int(math.Sqrt(float64(a)))
  for a != 1 {
      b := b0
      var found bool = false
      for b <= sqrtia {
          if a % b == 0 {
              a /= b
              b0 = b
              b = a
              sqrtia = int(math.Sqrt(float64(a)))
              found = true
          }
          b += 1
      }
      if !found {
          fmt.Printf("%d\n", a)
          a = 1
      }
  }
}

