package main
import "fmt"
func next0(n int) int{
  if n % 2 == 0 {
      return n / 2
  } else {
      return 3 * n + 1
  }
}

func find(n int, m []int) int{
  if n == 1 {
      return 1
  } else if n >= 1000000 {
      return 1 + find(next0(n), m)
  } else if m[n] != 0 {
      return m[n]
  } else {
      m[n] = 1 + find(next0(n), m)
      return m[n]
  }
}

func main() {
  var m []int = make([]int, 1000000)
  for j := 0; j < 1000000; j += 1 {
      m[j] = 0
  }
  max0 := 0
  maxi := 0
  for i := 1; i <= 999; i += 1 {
      /* normalement on met 999999 mais ça dépasse les int32... */
      n2 := find(i, m)
      if n2 > max0 {
          max0 = n2
          maxi = i
      }
  }
  fmt.Printf("%d\n%d\n", max0, maxi)
}

