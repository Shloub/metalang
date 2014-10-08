package main
import "fmt"
func next0(n int) int{
  if (n % 2) == 0 {
    return n / 2
  } else {
    return 3 * n + 1
  }
}

func find(n int, m []int) int{
  if n == 1 {
    return 1
  } else if n >= 1000000 {
    return 1 + find(next0(n), m)
  } else if m[n] != 0 {
    return m[n]
  } else {
    m[n] = 1 + find(next0(n), m);
    return m[n]
  }  
}

func main() {
  var m []int = make([]int, 1000000)
  for j := 0 ; j <= 1000000 - 1; j++ {
    m[j] = 0;
  }
  var max0 int = 0
  var maxi int = 0
  for i := 1 ; i <= 999; i++ {
    /* normalement on met 999999 mais ça dépasse les int32... */
      var n2 int = find(i, m)
      if n2 > max0 {
        max0 = n2;
          maxi = i;
      }
  }
  fmt.Printf("%d\n%d\n", max0, maxi);
}

