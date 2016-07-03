package main
import "fmt"
func main() {
  var f []int = make([]int, 10)
  for j := 0; j < 10; j += 1 {
      f[j] = 1
  }
  for i := 1; i < 10; i += 1 {
      f[i] *= i * f[i - 1]
      fmt.Printf("%d ", f[i])
  }
  out0 := 0
  fmt.Printf("\n")
  for a := 0; a < 10; a += 1 {
      for b := 0; b < 10; b += 1 {
          for c := 0; c < 10; c += 1 {
              for d := 0; d < 10; d += 1 {
                  for e := 0; e < 10; e += 1 {
                      for g := 0; g < 10; g += 1 {
                          sum := f[a] + f[b] + f[c] + f[d] + f[e] + f[g]
                          num := ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
                          if a == 0 {
                              sum -= 1
                              if b == 0 {
                                  sum -= 1
                                  if c == 0 {
                                      sum -= 1
                                      if d == 0 {
                                          sum -= 1
                                      }
                                  }
                              }
                          }
                          if sum == num && sum != 1 && sum != 2 {
                              out0 += num
                              fmt.Printf("%d ", num)
                          }
                      }
                  }
              }
          }
      }
  }
  fmt.Printf("\n%d\n", out0)
}

