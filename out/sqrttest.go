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
  fmt.Printf("%d %d %d %d %d %d ", isqrt(4), isqrt(16), isqrt(20), isqrt(1000), isqrt(500), isqrt(10));
}

