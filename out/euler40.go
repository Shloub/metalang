package main
import "fmt"
func exp0(a int, e int) int{
  var o int = 1
  for i := 1 ; i <= e; i++ {
    o *= a;
  }
  return o
}

func e(t []int, n int) int{
  for i := 1 ; i <= 8; i++ {
    if n >= t[i] * i {
        n -= t[i] * i;
      } else {
        var nombre int = exp0(10, i - 1) + n / i
        var chiffre int = i - 1 - n % i
        return nombre / exp0(10, chiffre) % 10
      }
  }
  return -1
}

func main() {
  var t []int = make([]int, 9)
  for i := 0 ; i <= 9 - 1; i++ {
    t[i] = exp0(10, i) - exp0(10, i - 1);
  }
  for i2 := 1 ; i2 <= 8; i2++ {
    fmt.Printf("%d => %d\n", i2, t[i2]);
  }
  for j := 0 ; j <= 80; j++ {
    fmt.Printf("%d", e(t, j));
  }
  fmt.Printf("\n");
  for k := 1 ; k <= 50; k++ {
    fmt.Printf("%d", k);
  }
  fmt.Printf("\n");
  for j2 := 169 ; j2 <= 220; j2++ {
    fmt.Printf("%d", e(t, j2));
  }
  fmt.Printf("\n");
  for k2 := 90 ; k2 <= 110; k2++ {
    fmt.Printf("%d", k2);
  }
  fmt.Printf("\n");
  var out0 int = 1
  for l := 0 ; l <= 6; l++ {
    var puiss int = exp0(10, l)
      var v int = e(t, puiss - 1)
      out0 *= v;
      fmt.Printf("10^%d=%d v=%d\n", l, puiss, v);
  }
  fmt.Printf("%d\n", out0);
}

