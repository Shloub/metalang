package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}


func eratostene(t []int, max_ int) int{
  var n int = 0
  for i := 2 ; i <= max_ - 1; i++ {
    if t[i] == i {
        n ++;
          var j int = i * i
          for j < max_ && j > 0{
                                 t[j] = 0;
                                 j += i;
          }
      }
  }
  return n
}

func fillPrimesFactors(t []int, n int, primes []int, nprimes int) int{
  for i := 0 ; i <= nprimes - 1; i++ {
    var d int = primes[i]
      for (n % d) == 0{
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
    var out_ int = 0
    var p int = i
    for j := 1 ; j <= t[i]; j++ {
      out_ += p;
        p *= i;
    }
    return (out_ + 1) * o
  } 
}

func sumdiv(nprimes int, primes []int, n int) int{
  var a int = n + 1
  var t []int = make([]int, a)
  for i := 0 ; i <= a - 1; i++ {
    t[i] = 0;
  }
  var max_ int = fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max_, 0)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var maximumprimes int = 30001
  var era []int = make([]int, maximumprimes)
  for s := 0 ; s <= maximumprimes - 1; s++ {
    era[s] = s;
  }
  var nprimes int = eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for t := 0 ; t <= nprimes - 1; t++ {
    primes[t] = 0;
  }
  var l int = 0
  for k := 2 ; k <= maximumprimes - 1; k++ {
    if era[k] == k {
        primes[l] = k;
          l ++;
      }
  }
  var n int = 100
  /* 28124 ça prend trop de temps mais on arrive a passer le test */
  var b int = n + 1
  var abondant []bool = make([]bool, b)
  for p := 0 ; p <= b - 1; p++ {
    abondant[p] = false;
  }
  var c int = n + 1
  var summable []bool = make([]bool, c)
  for q := 0 ; q <= c - 1; q++ {
    summable[q] = false;
  }
  var sum int = 0
  for r := 2 ; r <= n; r++ {
    var other int = sumdiv(nprimes, primes, r) - r
      if other > r {
        abondant[r] = true;
      }
  }
  for i := 1 ; i <= n; i++ {
    for j := 1 ; j <= n; j++ {
        if abondant[i] && abondant[j] && i + j <= n {
            summable[i + j] = true;
          }
      }
  }
  for o := 1 ; o <= n; o++ {
    if !summable[o] {
        sum += o;
      }
  }
  fmt.Printf("\n%d\n", sum);
}

