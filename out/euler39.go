package main
import "fmt"
import "math"
func main() {
  var t []int = make([]int, 1001)
  for i := 0 ; i <= 1001 - 1; i++ {
    t[i] = 0;
  }
  for a := 1 ; a <= 1000; a++ {
    for b := 1 ; b <= 1000; b++ {
        var c2 int = a * a + b * b
          var c int = int(math.Sqrt(float64(c2)))
          if c * c == c2 {
            var p int = a + b + c
              if p <= 1000 {
                t[p] = t[p] + 1;
              }
          }
      }
  }
  var j int = 0
  for k := 1 ; k <= 1000; k++ {
    if t[k] > t[j] {
        j = k;
      }
  }
  fmt.Printf("%d", j);
}

