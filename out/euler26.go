package main
import "fmt"
func periode(restes []int, len int, a int, b int) int{
  for a != 0{
    var chiffre int = a / b
    _ = chiffre
    var reste int = a % b
    for i := 0 ; i < len; i++ {
      if restes[i] == reste {
          return len - i
        }
    }
    restes[len] = reste;
    len ++;
    a = reste * 10;
  }
  return 0
}

func main() {
  var t []int = make([]int, 1000)
  for j := 0 ; j < 1000; j++ {
    t[j] = 0;
  }
  var m int = 0
  var mi int = 0
  for i := 1 ; i <= 1000; i++ {
    var p int = periode(t, 0, 1, i)
      if p > m {
        mi = i;
          m = p;
      }
  }
  fmt.Printf("%d\n%d\n", mi, m);
}

