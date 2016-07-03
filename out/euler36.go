package main
import "fmt"
func palindrome2(pow2 []int, n int) bool{
  var t []bool = make([]bool, 20)
  for i := 0; i < 20; i++ {
      t[i] = n / pow2[i] % 2 == 1
  }
  nnum := 0
  for j := 1; j < 20; j++ {
      if t[j] {
          nnum = j
      }
  }
  for k := 0; k <= nnum / 2; k++ {
      if t[k] != t[nnum - k] {
          return false
      }
  }
  return true
}

func main() {
  p := 1
  var pow2 []int = make([]int, 20)
  for i := 0; i < 20; i++ {
      p *= 2
      pow2[i] = p / 2
  }
  sum := 0
  for d := 1; d < 10; d++ {
      if palindrome2(pow2, d) {
          fmt.Printf("%d\n", d)
          sum += d
      }
      if palindrome2(pow2, d * 10 + d) {
          fmt.Printf("%d\n", d * 10 + d)
          sum += d * 10 + d
      }
  }
  for a0 := 0; a0 < 5; a0++ {
      a := a0 * 2 + 1
      for b := 0; b < 10; b++ {
          for c := 0; c < 10; c++ {
              num0 := a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
              if palindrome2(pow2, num0) {
                  fmt.Printf("%d\n", num0)
                  sum += num0
              }
              num1 := a * 10000 + b * 1000 + c * 100 + b * 10 + a
              if palindrome2(pow2, num1) {
                  fmt.Printf("%d\n", num1)
                  sum += num1
              }
          }
          num2 := a * 100 + b * 10 + a
          if palindrome2(pow2, num2) {
              fmt.Printf("%d\n", num2)
              sum += num2
          }
          num3 := a * 1000 + b * 100 + b * 10 + a
          if palindrome2(pow2, num3) {
              fmt.Printf("%d\n", num3)
              sum += num3
          }
      }
  }
  fmt.Printf("sum=%d\n", sum)
}

