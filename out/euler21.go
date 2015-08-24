package main
import "fmt"
func eratostene(t []int, max0 int) int{
  var n int = 0
  for i := 2 ; i < max0; i++ {
    if t[i] == i {
        n ++;
          var j int = i * i
          for j < max0 && j > 0{
            t[j] = 0;
            j += i;
          }
      }
  }
  return n
}

func fillPrimesFactors(t []int, n int, primes []int, nprimes int) int{
  for i := 0 ; i < nprimes; i++ {
    var d int = primes[i]
      for n % d == 0{
        t[d] = t[d] + 1;
        n /= d;
      }
      if n == 1 {
        return primes[i]
      }
  }
  return n
}

func sumdivaux2(t []int, n int, i int) int{
  for i < n && t[i] == 0{
    i ++;
  }
  return i
}

func sumdivaux(t []int, n int, i int) int{
  if i > n {
    return 1
  } else if t[i] == 0 {
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
  } else {
    var o int = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
    var out0 int = 0
    var p int = i
    for j := 1 ; j <= t[i]; j++ {
      out0 += p;
        p *= i;
    }
    return (out0 + 1) * o
  } 
}

func sumdiv(nprimes int, primes []int, n int) int{
  var t []int = make([]int, n + 1)
  for i := 0 ; i < n + 1; i++ {
    t[i] = 0;
  }
  var max0 int = fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max0, 0)
}

func main() {
  var maximumprimes int = 1001
  var era []int = make([]int, maximumprimes)
  for j := 0 ; j < maximumprimes; j++ {
    era[j] = j;
  }
  var nprimes int = eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0 ; o < nprimes; o++ {
    primes[o] = 0;
  }
  var l int = 0
  for k := 2 ; k < maximumprimes; k++ {
    if era[k] == k {
        primes[l] = k;
          l ++;
      }
  }
  fmt.Printf("%d == %d\n", l, nprimes);
  var sum int = 0
  for n := 2 ; n <= 1000; n++ {
    var other int = sumdiv(nprimes, primes, n) - n
      if other > n {
        var othersum int = sumdiv(nprimes, primes, other) - other
          if othersum == n {
            fmt.Printf("%d & %d\n", other, n);
              sum += other + n;
          }
      }
  }
  fmt.Printf("\n%d\n", sum);
}

