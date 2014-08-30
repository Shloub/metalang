package main
import "fmt"
func main() {
  var lim int = 100
  var sum int = (lim * (lim + 1)) / 2
  var carressum int = sum * sum
  var sumcarres int = (lim * (lim + 1) * (2 * lim + 1)) / 6
  fmt.Printf("%d", carressum - sumcarres);
}

