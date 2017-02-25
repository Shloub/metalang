package main
import "fmt"
func eratostene(t []int, max0 int) int{
  sum := 0
  for i := 2; i < max0; i++ {
      if t[i] == i {
          sum += i
          if max0 / i > i {
              j := i * i
              for j < max0 && j > 0 {
                  t[j] = 0
                  j += i
              }
          }
      }
  }
  return sum
}
func main() {
  n := 100000
  /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
  var t []int = make([]int, n)
  for i := 0; i < n; i++ {
      t[i] = i
  }
  t[1] = 0
  fmt.Printf("%d\n", eratostene(t, n))
}

