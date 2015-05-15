package main
import "fmt"
func test(tab []int, len int) {
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d ", tab[i]);
  }
  fmt.Printf("\n");
}

func main() {
  var t []int = make([]int, 5)
  for i := 0 ; i <= 5 - 1; i++ {
    t[i] = 1;
  }
  test(t, 5);
}

