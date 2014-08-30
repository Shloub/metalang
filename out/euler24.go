package main
import "fmt"
func fact(n int) int{
  var prod int = 1
  for i := 2 ; i <= n; i++ {
    prod *= i;
  }
  return prod
}

func show(lim int, nth int) {
  var t []int = make([]int, lim)
  for i := 0 ; i <= lim - 1; i++ {
    t[i] = i;
  }
  var pris []bool = make([]bool, lim)
  for j := 0 ; j <= lim - 1; j++ {
    pris[j] = false;
  }
  for k := 1 ; k <= lim - 1; k++ {
    var n int = fact(lim - k)
      var nchiffre int = nth / n
      nth %= n;
      for l := 0 ; l <= lim - 1; l++ {
        if !pris[l] {
            if nchiffre == 0 {
                fmt.Printf("%d", l);
                  pris[l] = true;
              }
              nchiffre --;
          }
      }
  }
  for m := 0 ; m <= lim - 1; m++ {
    if !pris[m] {
        fmt.Printf("%d", m);
      }
  }
  fmt.Printf("\n");
}

func main() {
  show(10, 999999);
}

