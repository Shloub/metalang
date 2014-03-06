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


/*
La suite de fibonaci
*/
func fibo(a int, b int, i int) int{
  var out_ int = 0
  var a2 int = a
  var b2 int = b
  for j := 0 ; j <= i + 1; j++ {
    fmt.Printf("%d", j);
      out_ += a2;
      var tmp int = b2
      b2 += a2;
      a2 = tmp;
  }
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var c int = fibo(1, 2, 4)
  fmt.Printf("%d", c);
}

