package main
import "fmt"
func min2_(a int, b int) int{
  if a < b {
      return a
  } else {
      return b
  }
}

func eratostene(t []int, max0 int) int{
  n := 0
  for i := 2; i < max0; i += 1 {
      if t[i] == i {
          n += 1
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
  maximumprimes := 1000001
  var era []int = make([]int, maximumprimes)
  for j := 0; j < maximumprimes; j += 1 {
      era[j] = j
  }
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
  var sum []int = make([]int, nprimes)
  for i_ := 0; i_ < nprimes; i_ += 1 {
      sum[i_] = primes[i_]
  }
  maxl := 0
  var process bool = true
  stop := maximumprimes - 1
  len := 1
  resp := 1
  for process {
      process = false
      for i := 0; i <= stop; i += 1 {
          if i + len < nprimes {
              sum[i] += primes[i + len]
              if maximumprimes > sum[i] {
                  process = true
                  if era[sum[i]] == sum[i] {
                      maxl = len
                      resp = sum[i]
                  }
              } else {
                  stop = min2_(stop, i)
              }
          }
      }
      len += 1
  }
  fmt.Printf("%d\n%d\n", resp, maxl)
}

