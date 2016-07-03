package main
import "fmt"
/*
La suite de fibonaci
*/
func fibo(a int, b int, i int) int{
  out_ := 0
  a2 := a
  b2 := b
  for j := 0; j <= i + 1; j++ {
      fmt.Printf("%d", j)
      out_ += a2
      tmp := b2
      b2 += a2
      a2 = tmp
  }
  return out_
}

func main() {
  fmt.Printf("%d", fibo(1, 2, 4))
}

