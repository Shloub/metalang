package main
import "math";
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


func isqrt(c int) int{
  return int(math.Sqrt(float64(c)))
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a int = isqrt(4)
  fmt.Printf("%d ", a);
  var b int = isqrt(16)
  fmt.Printf("%d ", b);
  var d int = isqrt(20)
  fmt.Printf("%d ", d);
  var e int = isqrt(1000)
  fmt.Printf("%d ", e);
  var f int = isqrt(500)
  fmt.Printf("%d ", f);
  var g int = isqrt(10)
  fmt.Printf("%d ", g);
}

