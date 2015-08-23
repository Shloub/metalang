package main
import "fmt"
func id(b []bool) []bool{
  return b
}

func g(t []bool, index int) {
  t[index] = false;
}

func main() {
  var j int = 0
  var a []bool = make([]bool, 5)
  for i := 0 ; i <= 5 - 1; i++ {
    fmt.Printf("%d", i);
      j += i;
      a[i] = i % 2 == 0;
  }
  fmt.Printf("%d ", j);
  if a[0] {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
  g(id(a), 0);
  if a[0] {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

