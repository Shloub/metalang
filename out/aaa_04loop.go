package main
import "fmt"
func h(i int) bool{
  /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
  var j int = i - 2
  for j <= i + 2{
    if i % j == 5 {
      return true
    }
    j++;
  }
  return false
}

func main() {
  var j int = 0
  for k := 0 ; k <= 10; k++ {
    j += k;
      fmt.Printf("%d\n", j);
  }
  var i int = 4
  for i < 10{
    fmt.Printf("%d", i);
    i++;
    j += i;
  }
  fmt.Printf("%d%dFIN TEST\n", j, i);
}

