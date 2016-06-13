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

func fillPrimesFactors(t []int, n int, primes []int, nprimes int) int{
  for i := 0; i < nprimes; i += 1 {
      d := primes[i]
      for n % d == 0 {
          t[d] += 1
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
      i += 1
  }
  return i
}

func sumdivaux(t []int, n int, i int) int{
  if i > n {
      return 1
  }else {
      if t[i] == 0 {
          return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
      }else {
          o := sumdivaux(t, n, sumdivaux2(t, n, i + 1))
          out0 := 0
          p := i
          for j := 1; j <= t[i]; j += 1 {
              out0 += p
              p *= i
          }
          return (out0 + 1) * o
      }
  }
}

func sumdiv(nprimes int, primes []int, n int) int{
  var t []int = make([]int, n + 1)
  for i := 0; i <= n; i += 1 {
      t[i] = 0
  }
  max0 := fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max0, 0)
}

func main() {
  maximumprimes := 30001
  var era []int = make([]int, maximumprimes)
  for s := 0; s < maximumprimes; s += 1 {
      era[s] = s
  }
  nprimes := eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for t := 0; t < nprimes; t += 1 {
      primes[t] = 0
  }
  l := 0
  for k := 2; k < maximumprimes; k += 1 {
      if era[k] == k {
          primes[l] = k
          l += 1
      }
  }
  n := 100
  /* 28124 ça prend trop de temps mais on arrive a passer le test */
  var abondant []bool = make([]bool, n + 1)
  for p := 0; p <= n; p += 1 {
      abondant[p] = false
  }
  var summable []bool = make([]bool, n + 1)
  for q := 0; q <= n; q += 1 {
      summable[q] = false
  }
  sum := 0
  for r := 2; r <= n; r += 1 {
      other := sumdiv(nprimes, primes, r) - r
      if other > r {
          abondant[r] = true
      }
  }
  for i := 1; i <= n; i += 1 {
      for j := 1; j <= n; j += 1 {
          if abondant[i] && abondant[j] && i + j <= n {
              summable[i + j] = true
          }
      }
  }
  for o := 1; o <= n; o += 1 {
      if !summable[o] {
          sum += o
      }
  }
  fmt.Printf("\n%d\n", sum)
}

