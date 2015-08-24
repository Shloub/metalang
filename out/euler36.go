package main
import "fmt"
func palindrome2(pow2 []int, n int) bool{
  var t []bool = make([]bool, 20)
  for i := 0 ; i < 20; i++ {
    t[i] = n / pow2[i] % 2 == 1;
  }
  var nnum int = 0
  for j := 1 ; j <= 19; j++ {
    if t[j] {
        nnum = j;
      }
  }
  for k := 0 ; k <= nnum / 2; k++ {
    if t[k] != t[nnum - k] {
        return false
      }
  }
  return true
}

func main() {
  var p int = 1
  var pow2 []int = make([]int, 20)
  for i := 0 ; i < 20; i++ {
    p *= 2;
      pow2[i] = p / 2;
  }
  var sum int = 0
  for d := 1 ; d <= 9; d++ {
    if palindrome2(pow2, d) {
        fmt.Printf("%d\n", d);
          sum += d;
      }
      if palindrome2(pow2, d * 10 + d) {
        fmt.Printf("%d\n", d * 10 + d);
          sum += d * 10 + d;
      }
  }
  for a0 := 0 ; a0 <= 4; a0++ {
    var a int = a0 * 2 + 1
      for b := 0 ; b <= 9; b++ {
        for c := 0 ; c <= 9; c++ {
            var num0 int = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
              if palindrome2(pow2, num0) {
                fmt.Printf("%d\n", num0);
                  sum += num0;
              }
              var num1 int = a * 10000 + b * 1000 + c * 100 + b * 10 + a
              if palindrome2(pow2, num1) {
                fmt.Printf("%d\n", num1);
                  sum += num1;
              }
          }
          var num2 int = a * 100 + b * 10 + a
          if palindrome2(pow2, num2) {
            fmt.Printf("%d\n", num2);
              sum += num2;
          }
          var num3 int = a * 1000 + b * 100 + b * 10 + a
          if palindrome2(pow2, num3) {
            fmt.Printf("%d\n", num3);
              sum += num3;
          }
      }
  }
  fmt.Printf("sum=%d\n", sum);
}

