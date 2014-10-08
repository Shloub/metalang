package main
import "fmt"
func eratostene(t []int, max0 int) int{
  var n int = 0
  for i := 2 ; i <= max0 - 1; i++ {
    if t[i] == i {
        n ++;
          var j int = i * i
          if j / i == i {
            /* overflow test */
              for j < max0 && j > 0{
                t[j] = 0;
                j += i;
              }
          }
      }
  }
  return n
}

func main() {
  var maximumprimes int = 6000
  var era []int = make([]int, maximumprimes)
  for j_ := 0 ; j_ <= maximumprimes - 1; j_++ {
    era[j_] = j_;
  }
  var nprimes int = eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0 ; o <= nprimes - 1; o++ {
    primes[o] = 0;
  }
  var l int = 0
  for k := 2 ; k <= maximumprimes - 1; k++ {
    if era[k] == k {
        primes[l] = k;
          l ++;
      }
  }
  fmt.Printf("%d == %d\n", l, nprimes);
  var canbe []bool = make([]bool, maximumprimes)
  for i_ := 0 ; i_ <= maximumprimes - 1; i_++ {
    canbe[i_] = false;
  }
  for i := 0 ; i <= nprimes - 1; i++ {
    for j := 0 ; j <= maximumprimes - 1; j++ {
        var n int = primes[i] + 2 * j * j
          if n < maximumprimes {
            canbe[n] = true;
          }
      }
  }
  for m := 1 ; m <= maximumprimes; m++ {
    var m2 int = m * 2 + 1
      if m2 < maximumprimes && !canbe[m2] {
        fmt.Printf("%d\n", m2);
      }
  }
}

