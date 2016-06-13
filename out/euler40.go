package main
import "fmt"
func exp0(a int, e int) int{
  o := 1
  for i := 1; i <= e; i += 1 {
      o *= a
  }
  return o
}

func e(t []int, n int) int{
  for i := 1; i <= 8; i += 1 {
      if n >= t[i] * i {
          n -= t[i] * i
      }else {
          nombre := exp0(10, i - 1) + n / i
          chiffre := i - 1 - n % i
          return nombre / exp0(10, chiffre) % 10
      }
  }
  return -1
}

func main() {
  var t []int = make([]int, 9)
  for i := 0; i < 9; i += 1 {
      t[i] = exp0(10, i) - exp0(10, i - 1)
  }
  for i2 := 1; i2 <= 8; i2 += 1 {
      fmt.Printf("%d => %d\n", i2, t[i2])
  }
  for j := 0; j <= 80; j += 1 {
      fmt.Printf("%d", e(t, j))
  }
  fmt.Printf("\n")
  for k := 1; k <= 50; k += 1 {
      fmt.Printf("%d", k)
  }
  fmt.Printf("\n")
  for j2 := 169; j2 <= 220; j2 += 1 {
      fmt.Printf("%d", e(t, j2))
  }
  fmt.Printf("\n")
  for k2 := 90; k2 <= 110; k2 += 1 {
      fmt.Printf("%d", k2)
  }
  fmt.Printf("\n")
  out0 := 1
  for l := 0; l <= 6; l += 1 {
      puiss := exp0(10, l)
      v := e(t, puiss - 1)
      out0 *= v
      fmt.Printf("10^%d=%d v=%d\n", l, puiss, v)
  }
  fmt.Printf("%d\n", out0)
}

