package main
import "fmt"
func main() {
  /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
  for a := 1 ; a <= 1000; a++ {
    for b := a + 1 ; b <= 1000; b++ {
        var c int = 1000 - a - b
          var a2b2 int = a * a + b * b
          var cc int = c * c
          if cc == a2b2 && c > a {
            fmt.Printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c);
          }
      }
  }
}

