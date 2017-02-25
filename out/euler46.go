package main
import "fmt"
func eratostene(t []int, max0 int) int{
  n := 0
  for i := 2; i < max0; i++ {
      if t[i] == i {
          n++
          if max0 / i > i {
              j := i * i
              for j < max0 && j > 0 {
                  t[j] = 0
                  j += i
              }
          }
      }
  }
  return n
}
func main() {
  maximumprimes := 6000
  var era []int = make([]int, maximumprimes)
  for j_ := 0; j_ < maximumprimes; j_++ {
      era[j_] = j_
  }
  nprimes := eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0; o < nprimes; o++ {
      primes[o] = 0
  }
  l := 0
  for k := 2; k < maximumprimes; k++ {
      if era[k] == k {
          primes[l] = k
          l++
      }
  }
  fmt.Printf("%d == %d\n", l, nprimes)
  var canbe []bool = make([]bool, maximumprimes)
  for i_ := 0; i_ < maximumprimes; i_++ {
      canbe[i_] = false
  }
  for i := 0; i < nprimes; i++ {
      for j := 0; j < maximumprimes; j++ {
          n := primes[i] + 2 * j * j
          if n < maximumprimes {
              canbe[n] = true
          }
      }
  }
  for m := 1; m <= maximumprimes; m++ {
      m2 := m * 2 + 1
      if m2 < maximumprimes && !canbe[m2] {
          fmt.Printf("%d\n", m2)
      }
  }
}

