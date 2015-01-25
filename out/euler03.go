package main
import "fmt"
import "math"
func main() {
  var maximum int = 1
  _ = maximum
  var b0 int = 2
  var a int = 408464633
  var sqrtia int = int(math.Sqrt(float64(a)))
  for a != 1{
    var b int = b0
    var found bool = false
    for b <= sqrtia{
      if (a % b) == 0 {
        a /= b;
          b0 = b;
          b = a;
          var e int = int(math.Sqrt(float64(a)))
          sqrtia = e;
          found = true;
      }
      b ++;
    }
    if !found {
      fmt.Printf("%d\n", a);
        a = 1;
    }
  }
}

