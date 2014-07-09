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


func divisible(n int, t []int, size int) bool{
  for i := 0 ; i <= size - 1; i++ {
    if (n % t[i]) == 0 {
        return true
      }
  }
  return false
}

func find(n int, t []int, used int, nth int) int{
  for used != nth{
                   if divisible(n, t, used) {
                     n ++;
                   } else {
                     t[used] = n;
                     n ++;
                     used ++;
                   }
  }
  return t[used - 1]
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int = 10001
  var t []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    t[i] = 2;
  }
  fmt.Printf("%d\n", find(3, t, 1, n));
}

