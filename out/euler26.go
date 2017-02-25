package main
import "fmt"
func periode(restes []int, len int, a int, b int) int{
  for a != 0 {
      chiffre := a / b
      _ = chiffre
      reste := a % b
      for i := 0; i < len; i++ {
          if restes[i] == reste {
              return len - i
          }
      }
      restes[len] = reste
      len++
      a = reste * 10
  }
  return 0
}
func main() {
  var t []int = make([]int, 1000)
  for j := 0; j < 1000; j++ {
      t[j] = 0
  }
  m := 0
  mi := 0
  for i := 1; i < 1001; i++ {
      p := periode(t, 0, 1, i)
      if p > m {
          mi = i
          m = p
      }
  }
  fmt.Printf("%d\n%d\n", mi, m)
}

