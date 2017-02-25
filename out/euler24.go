package main
import "fmt"
func fact(n int) int{
  prod := 1
  for i := 2; i <= n; i++ {
      prod *= i
  }
  return prod
}
func show(lim int, nth int) {
  var t []int = make([]int, lim)
  for i := 0; i < lim; i++ {
      t[i] = i
  }
  var pris []bool = make([]bool, lim)
  for j := 0; j < lim; j++ {
      pris[j] = false
  }
  for k := 1; k < lim; k++ {
      n := fact(lim - k)
      nchiffre := nth / n
      nth = nth % n
      for l := 0; l < lim; l++ {
          if !pris[l] {
              if nchiffre == 0 {
                  fmt.Printf("%d", l)
                  pris[l] = true
              }
              nchiffre--
          }
      }
  }
  for m := 0; m < lim; m++ {
      if !pris[m] {
          fmt.Printf("%d", m)
      }
  }
  fmt.Printf("\n")
}
func main() {
  show(10, 999999)
}

