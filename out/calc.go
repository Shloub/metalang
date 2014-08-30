package main
import "fmt"
/*
La suite de fibonaci
*/
func fibo(a int, b int, i int) int{
  var out_ int = 0
  var a2 int = a
  var b2 int = b
  for j := 0 ; j <= i + 1; j++ {
    fmt.Printf("%d", j);
      out_ += a2;
      var tmp int = b2
      b2 += a2;
      a2 = tmp;
  }
  return out_
}

func main() {
  fmt.Printf("%d", fibo(1, 2, 4));
}

