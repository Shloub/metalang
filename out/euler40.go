package main
import "fmt"
func exp0(a int, e int) int{
  o := 1
  for i := 1; i <= e; i++ {
      o *= a
  }
  return o
}

func e(t []int, n int) int{
  for i := 1; i < 9; i++ {
      if n >= t[i] * i {
          n -= t[i] * i
      } else {
          nombre := exp0(10, i - 1) + n / i
          chiffre := i - 1 - n % i
          return nombre / exp0(10, chiffre) % 10
      }
  }
  return -1
}

func main() {
  var t []int = make([]int, 9)
  for i := 0; i < 9; i++ {
      t[i] = exp0(10, i) - exp0(10, i - 1)
  }
  for i2 := 1; i2 < 9; i2++ {
      fmt.Printf("%d => %d\n", i2, t[i2])
  }
  for j := 0; j < 81; j++ {
      fmt.Printf("%d", e(t, j))
  }
  fmt.Printf("\n")
  for k := 1; k < 51; k++ {
      fmt.Printf("%d", k)
  }
  fmt.Printf("\n")
  for j2 := 169; j2 < 221; j2++ {
      fmt.Printf("%d", e(t, j2))
  }
  fmt.Printf("\n")
  for k2 := 90; k2 < 111; k2++ {
      fmt.Printf("%d", k2)
  }
  fmt.Printf("\n")
  out0 := 1
  for l := 0; l < 7; l++ {
      puiss := exp0(10, l)
      v := e(t, puiss - 1)
      out0 *= v
      fmt.Printf("10^%d=%d v=%d\n", l, puiss, v)
  }
  fmt.Printf("%d\n", out0)
}

