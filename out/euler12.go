package main
import "fmt"
func max2_(a int, b int) int{
  if a > b {
      return a
  }else {
      return b
  }
}

func eratostene(t []int, max0 int) int{
  n := 0
  for i := 2; i < max0; i += 1 {
      if t[i] == i {
          j := i * i
          n += 1
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

func find(ndiv2 int) int{
  maximumprimes := 110
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
  for n := 1; n <= 10000; n += 1 {
      var primesFactors []int = make([]int, n + 2)
      for m := 0; m < n + 2; m += 1 {
          primesFactors[m] = 0
      }
      max0 := max2_(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes))
      primesFactors[2] -= 1
      ndivs := 1
      for i := 0; i <= max0; i += 1 {
          if primesFactors[i] != 0 {
              ndivs *= 1 + primesFactors[i]
          }
      }
      if ndivs > ndiv2 {
          return n * (n + 1) / 2
      }
      /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
  }
  return 0
}

func main() {
  fmt.Printf("%d\n", find(500))
}

