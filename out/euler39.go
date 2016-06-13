package main
import "fmt"
import "math"
func main() {
  var t []int = make([]int, 1001)
  for i := 0; i < 1001; i += 1 {
      t[i] = 0
  }
  for a := 1; a <= 1000; a += 1 {
      for b := 1; b <= 1000; b += 1 {
          c2 := a * a + b * b
          c := int(math.Sqrt(float64(c2)))
          if c * c == c2 {
              p := a + b + c
              if p <= 1000 {
                  t[p] += 1
              }
          }
      }
  }
  j := 0
  for k := 1; k <= 1000; k += 1 {
      if t[k] > t[j] {
          j = k
      }
  }
  fmt.Printf("%d", j)
}

