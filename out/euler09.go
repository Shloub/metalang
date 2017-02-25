package main
import "fmt"

func main() {
  /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
  for a := 1; a < 1001; a++ {
      for b := a + 1; b < 1001; b++ {
          c := 1000 - a - b
          a2b2 := a * a + b * b
          cc := c * c
          if cc == a2b2 && c > a {
              fmt.Printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c)
          }
      }
  }
}

