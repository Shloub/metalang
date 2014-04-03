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


func main() {
  reader = bufio.NewReader(os.Stdin)
  var lim int = 100
  var sum int = (lim * (lim + 1)) / 2
  var carressum int = sum * sum
  var sumcarres int = (lim * (lim + 1) * (2 * lim + 1)) / 6
  var a int = carressum - sumcarres
  fmt.Printf("%d", a);
}

