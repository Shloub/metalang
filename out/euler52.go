package main
import "fmt"
func chiffre_sort(a int) int{
  if a < 10 {
    return a
  } else {
    var b int = chiffre_sort(a / 10)
    var c int = a % 10
    var d int = b % 10
    var e int = b / 10
    if c < d {
      return c + b * 10
    } else {
      return d + chiffre_sort(c + e * 10) * 10
    }
  }
}

func same_numbers(a int, b int, c int, d int, e int, f int) bool{
  var ca int = chiffre_sort(a)
  return ca == chiffre_sort(b) && ca == chiffre_sort(c) && ca == chiffre_sort(d) && ca == chiffre_sort(e) && ca == chiffre_sort(f)
}

func main() {
  var num int = 142857
  if same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5) {
    fmt.Printf("%d %d %d %d %d %d\n", num, num * 2, num * 3, num * 4, num * 5, num * 6);
  }
}

