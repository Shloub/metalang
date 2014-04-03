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
  var a int = 10001
  var t []int = make([]int, a)
  for i := 0 ; i <= a - 1; i++ {
    t[i] = 2;
  }
  var b int = find(3, t, 1, 10001)
  fmt.Printf("%d\n", b);
}

