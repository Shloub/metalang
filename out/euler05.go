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


func max2(a int, b int) int{
  if a > b {
    return a
  } else {
    return b
  }
}

func primesfactors(n int) []int{
  var c int = n + 1
  var tab []int = make([]int, c)
  for i := 0 ; i <= c - 1; i++ {
    tab[i] = 0;
  }
  var d int = 2
  for n != 1 && d * d <= n{
                            if (n % d) == 0 {
                              tab[d] = tab[d] + 1;
                                n /= d;
                            } else {
                              d ++;
                            }
  }
  tab[n] = tab[n] + 1;
  return tab
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var lim int = 20
  var e int = lim + 1
  var o []int = make([]int, e)
  for m := 0 ; m <= e - 1; m++ {
    o[m] = 0;
  }
  for i := 1 ; i <= lim; i++ {
    var t []int = primesfactors(i)
      for j := 1 ; j <= i; j++ {
        o[j] = max2(o[j], t[j]);
      }
  }
  var product int = 1
  for k := 1 ; k <= lim; k++ {
    for l := 1 ; l <= o[k]; l++ {
        product *= k;
      }
  }
  fmt.Printf("%d\n", product);
}

