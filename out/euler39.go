package main
import "fmt"
import "math"

func main() {
  var t []int = make([]int, 1001)
  for i := 0; i < 1001; i++ {
      t[i] = 0
  }
  for a := 1; a < 1001; a++ {
      for b := 1; b < 1001; b++ {
          c2 := a * a + b * b
          c := int(math.Sqrt(float64(c2)))
          if c * c == c2 {
              p := a + b + c
              if p < 1001 {
                  t[p]++
              }
          }
      }
  }
  j := 0
  for k := 1; k < 1001; k++ {
      if t[k] > t[j] {
          j = k
      }
  }
  fmt.Printf("%d", j)
}

