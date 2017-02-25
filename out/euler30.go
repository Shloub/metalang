package main
import "fmt"

func main() {
  /*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
  var p []int = make([]int, 10)
  for i := 0; i < 10; i++ {
      p[i] = i * i * i * i * i
  }
  sum := 0
  for a := 0; a < 10; a++ {
      for b := 0; b < 10; b++ {
          for c := 0; c < 10; c++ {
              for d := 0; d < 10; d++ {
                  for e := 0; e < 10; e++ {
                      for f := 0; f < 10; f++ {
                          s := p[a] + p[b] + p[c] + p[d] + p[e] + p[f]
                          r := a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
                          if s == r && r != 1 {
                              fmt.Printf("%d%d%d%d%d%d %d\n", f, e, d, c, b, a, r)
                              sum += r
                          }
                      }
                  }
              }
          }
      }
  }
  fmt.Printf("%d", sum)
}

