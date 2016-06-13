package main
import "fmt"
func max2_(a int, b int) int{
  if a > b {
      return a
  }else {
      return b
  }
}

func min2_(a int, b int) int{
  if a < b {
      return a
  }else {
      return b
  }
}

func pgcd(a int, b int) int{
  c := min2_(a, b)
  d := max2_(a, b)
  reste := d % c
  if reste == 0 {
      return c
  }else {
      return pgcd(c, reste)
  }
}

func main() {
  top := 1
  bottom := 1
  for i := 1; i <= 9; i += 1 {
      for j := 1; j <= 9; j += 1 {
          for k := 1; k <= 9; k += 1 {
              if i != j && j != k {
                  a := i * 10 + j
                  b := j * 10 + k
                  if a * k == i * b {
                      fmt.Printf("%d/%d\n", a, b)
                      top *= a
                      bottom *= b
                  }
              }
          }
      }
  }
  fmt.Printf("%d/%d\n", top, bottom)
  p := pgcd(top, bottom)
  fmt.Printf("pgcd=%d\n%d\n", p, bottom / p)
}

