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

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b int = 4
  fmt.Printf("%d ", int(math.Sqrt(float64(b))));
  var e int = 16
  fmt.Printf("%d ", int(math.Sqrt(float64(e))));
  var g int = 20
  fmt.Printf("%d ", int(math.Sqrt(float64(g))));
  var i int = 1000
  fmt.Printf("%d ", int(math.Sqrt(float64(i))));
  var k int = 500
  fmt.Printf("%d ", int(math.Sqrt(float64(k))));
  var m int = 10
  fmt.Printf("%d ", int(math.Sqrt(float64(m))));
}

