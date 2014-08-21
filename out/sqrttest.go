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
  var a int = int(math.Sqrt(float64(b)))
  fmt.Printf("%d ", a);
  var e int = 16
  var d int = int(math.Sqrt(float64(e)))
  fmt.Printf("%d ", d);
  var g int = 20
  var f int = int(math.Sqrt(float64(g)))
  fmt.Printf("%d ", f);
  var i int = 1000
  var h int = int(math.Sqrt(float64(i)))
  fmt.Printf("%d ", h);
  var k int = 500
  var j int = int(math.Sqrt(float64(k)))
  fmt.Printf("%d ", j);
  var m int = 10
  var l int = int(math.Sqrt(float64(m)))
  fmt.Printf("%d ", l);
}

