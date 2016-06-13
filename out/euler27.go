package main
import "fmt"
func eratostene(t []int, max0 int) int{
  n := 0
  for i := 2; i < max0; i += 1 {
      if t[i] == i {
          n += 1
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
      i += 1
  }
  return true
}

func test(a int, b int, primes []int, len int) int{
  for n := 0; n <= 200; n += 1 {
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
  for j := 0; j < maximumprimes; j += 1 {
      era[j] = j
  }
  result := 0
  max0 := 0
  nprimes := eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0; o < nprimes; o += 1 {
      primes[o] = 0
  }
  l := 0
  for k := 2; k < maximumprimes; k += 1 {
      if era[k] == k {
          primes[l] = k
          l += 1
      }
  }
  fmt.Printf("%d == %d\n", l, nprimes)
  ma := 0
  mb := 0
  for b := 3; b <= 999; b += 1 {
      if era[b] == b {
          for a := -999; a <= 999; a += 1 {
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

