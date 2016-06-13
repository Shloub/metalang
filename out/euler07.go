package main
import "fmt"
func divisible(n int, t []int, size int) bool{
  for i := 0; i < size; i += 1 {
      if n % t[i] == 0 {
          return true
      }
  }
  return false
}

func find(n int, t []int, used int, nth int) int{
  for used != nth {
      if divisible(n, t, used) {
          n += 1
      } else {
          t[used] = n
          n += 1
          used += 1
      }
  }
  return t[used - 1]
}

func main() {
  n := 10001
  var t []int = make([]int, n)
  for i := 0; i < n; i += 1 {
      t[i] = 2
  }
  fmt.Printf("%d\n", find(3, t, 1, n))
}

