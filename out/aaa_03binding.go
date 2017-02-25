package main
import "fmt"
func g(i int) int{
  j := i * 4
  if j % 2 == 1 {
      return 0
  }
  return j
}
func h(i int) {
  fmt.Printf("%d\n", i)
}
func main() {
  h(14)
  a := 4
  b := 5
  fmt.Printf("%d", a + b)
  /* main */
  h(15)
  a = 2
  b = 1
  fmt.Printf("%d", a + b)
}

