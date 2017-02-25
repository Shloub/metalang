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
func fillPrimesFactors(t []int, n int, primes []int, nprimes int) int{
  for i := 0; i < nprimes; i++ {
      d := primes[i]
      for n % d == 0 {
          t[d]++
          n /= d
      }
      if n == 1 {
          return primes[i]
      }
  }
  return n
}
func sumdivaux2(t []int, n int, i int) int{
  for i < n && t[i] == 0 {
      i++
  }
  return i
}
func sumdivaux(t []int, n int, i int) int{
  if i > n {
      return 1
  } else if t[i] == 0 {
      return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
  } else {
      o := sumdivaux(t, n, sumdivaux2(t, n, i + 1))
      out0 := 0
      p := i
      for j := 1; j <= t[i]; j++ {
          out0 += p
          p *= i
      }
      return (out0 + 1) * o
  }
}
func sumdiv(nprimes int, primes []int, n int) int{
  var t []int = make([]int, n + 1)
  for i := 0; i <= n; i++ {
      t[i] = 0
  }
  max0 := fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max0, 0)
}
func main() {
  maximumprimes := 1001
  var era []int = make([]int, maximumprimes)
  for j := 0; j < maximumprimes; j++ {
      era[j] = j
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
  sum := 0
  for n := 2; n < 1001; n++ {
      other := sumdiv(nprimes, primes, n) - n
      if other > n {
          othersum := sumdiv(nprimes, primes, other) - other
          if othersum == n {
              fmt.Printf("%d & %d\n", other, n)
              sum += other + n
          }
      }
  }
  fmt.Printf("\n%d\n", sum)
}

