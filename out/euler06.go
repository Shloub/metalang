package main
import "fmt"

func main() {
  lim := 100
  sum := lim * (lim + 1) / 2
  carressum := sum * sum
  sumcarres := lim * (lim + 1) * (2 * lim + 1) / 6
  fmt.Printf("%d", carressum - sumcarres)
}

