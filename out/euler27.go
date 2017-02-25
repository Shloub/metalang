package main
import "fmt"
func eratostene(t []int, max0 int) int{
  n := 0
  for i := 2; i < max0; i++ {
      if t[i] == i {
          n++
          j := i * i
          for j < max0 && j > 0 {
              t[j] = 0
              j += i
          }
      }
  }
  return n
}
func isPrime(n int, primes []int, len int) bool{
  i := 0
  if n < 0 {
      n = -n
  }
  for primes[i] * primes[i] < n {
      if n % primes[i] == 0 {
          return false
      }
      i++
  }
  return true
}
func test(a int, b int, primes []int, len int) int{
  for n := 0; n < 201; n++ {
      j := n * n + a * n + b
      if !isPrime(j, primes, len) {
          return n
      }
  }
  return 200
}
func main() {
  maximumprimes := 1000
  var era []int = make([]int, maximumprimes)
  for j := 0; j < maximumprimes; j++ {
      era[j] = j
  }
  result := 0
  max0 := 0
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
  ma := 0
  mb := 0
  for b := 3; b < 1000; b++ {
      if era[b] == b {
          for a := -999; a < 1000; a++ {
              n1 := test(a, b, primes, nprimes)
              n2 := test(a, -b, primes, nprimes)
              if n1 > max0 {
                  max0 = n1
                  result = a * b
                  ma = a
                  mb = b
              }
              if n2 > max0 {
                  max0 = n2
                  result = -a * b
                  ma = a
                  mb = -b
              }
          }
      }
  }
  fmt.Printf("%d %d\n%d\n%d\n", ma, mb, max0, result)
}

