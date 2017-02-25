package main
import "fmt"
func max2_(a int, b int) int{
  if a > b {
      return a
  } else {
      return b
  }
}
func primesfactors(n int) []int{
  var tab []int = make([]int, n + 1)
  for i := 0; i <= n; i++ {
      tab[i] = 0
  }
  d := 2
  for n != 1 && d * d <= n {
      if n % d == 0 {
          tab[d]++
          n /= d
      } else {
          d++
      }
  }
  tab[n]++
  return tab
}
func main() {
  lim := 20
  var o []int = make([]int, lim + 1)
  for m := 0; m <= lim; m++ {
      o[m] = 0
  }
  for i := 1; i <= lim; i++ {
      var t []int = primesfactors(i)
      for j := 1; j <= i; j++ {
          o[j] = max2_(o[j], t[j])
      }
  }
  product := 1
  for k := 1; k <= lim; k++ {
      for l := 1; l <= o[k]; l++ {
          product *= k
      }
  }
  fmt.Printf("%d\n", product)
}

