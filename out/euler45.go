package main
import "fmt"
func triangle(n int) int{
  if n % 2 == 0 {
      return (n / 2) * (n + 1)
  } else {
      return n * ((n + 1) / 2)
  }
}

func penta(n int) int{
  if n % 2 == 0 {
      return (n / 2) * (3 * n - 1)
  } else {
      return ((3 * n - 1) / 2) * n
  }
}

func hexa(n int) int{
  return n * (2 * n - 1)
}

func findPenta2(n int, a int, b int) bool{
  if b == a + 1 {
      return penta(a) == n || penta(b) == n
  }
  c := (a + b) / 2
  p := penta(c)
  if p == n {
      return true
  } else if p < n {
      return findPenta2(n, c, b)
  } else {
      return findPenta2(n, a, c)
  }
}

func findHexa2(n int, a int, b int) bool{
  if b == a + 1 {
      return hexa(a) == n || hexa(b) == n
  }
  c := (a + b) / 2
  p := hexa(c)
  if p == n {
      return true
  } else if p < n {
      return findHexa2(n, c, b)
  } else {
      return findHexa2(n, a, c)
  }
}

func main() {
  for n := 285; n < 55386; n++ {
      t := triangle(n)
      if findPenta2(t, n / 5, n) && findHexa2(t, n / 5, n / 2 + 10) {
          fmt.Printf("%d\n%d\n", n, t)
      }
  }
}

