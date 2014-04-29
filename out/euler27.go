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

func isPrime(n int, primes []int, len int) bool{
  var i int = 0
  if n < 0 {
    n = -n;
  }
  for primes[i] * primes[i] < n{
                                 if (n % primes[i]) == 0 {
                                   return false
                                 }
                                 i ++;
  }
  return true
}

func test(a int, b int, primes []int, len int) int{
  for n := 0 ; n <= 200; n++ {
    var j int = n * n + a * n + b
      if !isPrime(j, primes, len) {
        return n
      }
  }
  return 200
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var maximumprimes int = 1000
  var era []int = make([]int, maximumprimes)
  for j := 0 ; j <= maximumprimes - 1; j++ {
    era[j] = j;
  }
  var result int = 0
  var max_ int = 0
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
  var ma int = 0
  var mb int = 0
  for b := 3 ; b <= 999; b++ {
    if era[b] == b {
        for a := -999 ; a <= 999; a++ {
            var n1 int = test(a, b, primes, nprimes)
              var n2 int = test(a, -b, primes, nprimes)
              if n1 > max_ {
                max_ = n1;
                  result = a * b;
                  ma = a;
                  mb = b;
              }
              if n2 > max_ {
                max_ = n2;
                  result = -a * b;
                  ma = a;
                  mb = -b;
              }
          }
      }
  }
  fmt.Printf("%d %d\n%d\n%d\n", ma, mb, max_, result);
}

