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


func next_(n int) int{
  if (n % 2) == 0 {
    return n / 2
  } else {
    return 3 * n + 1
  }
}

func find(n int, m []int) int{
  if n == 1 {
    return 1
  } else if n >= 1000000 {
    return 1 + find(next_(n), m)
  } else if m[n] != 0 {
    return m[n]
  } else {
    m[n] = 1 + find(next_(n), m);
    return m[n]
  }  
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = 1000000
  var m []int = make([]int, a)
  for j := 0 ; j <= a - 1; j++ {
    m[j] = 0;
  }
  var max_ int = 0
  var maxi int = 0
  for i := 1 ; i <= 999; i++ {
    /* normalement on met 999999 mais ça dépasse les int32... */
      var n2 int = find(i, m)
      if n2 > max_ {
        max_ = n2;
          maxi = i;
      }
  }
  fmt.Printf("%d\n%d\n", max_, maxi);
}

