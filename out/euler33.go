package main
import "fmt"
func max2_(a int, b int) int{
  if a > b {
    return a
  } else {
    return b
  }
}

func min2_(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func pgcd(a int, b int) int{
  var c int = min2_(a, b)
  var d int = max2_(a, b)
  var reste int = d % c
  if reste == 0 {
    return c
  } else {
    return pgcd(c, reste)
  }
}

func main() {
  var top int = 1
  var bottom int = 1
  for i := 1 ; i <= 9; i++ {
    for j := 1 ; j <= 9; j++ {
        for k := 1 ; k <= 9; k++ {
            if i != j && j != k {
                var a int = i * 10 + j
                  var b int = j * 10 + k
                  if a * k == i * b {
                    fmt.Printf("%d/%d\n", a, b);
                      top *= a;
                      bottom *= b;
                  }
              }
          }
      }
  }
  fmt.Printf("%d/%d\n", top, bottom);
  var p int = pgcd(top, bottom)
  fmt.Printf("pgcd=%d\n%d\n", p, bottom / p);
}

