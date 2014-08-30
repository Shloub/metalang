package main
import "fmt"
func main() {
  var a int = 1
  var b int = 2
  var sum int = 0
  for a < 4000000{
    if (a % 2) == 0 {
      sum += a;
    }
    var c int = a
    a = b;
    b += c;
  }
  fmt.Printf("%d\n", sum);
}

