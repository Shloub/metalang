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
  var c []byte = make([]byte, 12)
  for d := 0 ; d <= 12 - 1; d++ {
    fmt.Fscanf(reader, "%c", &c[d])
  }
  skip()
  var str []byte = c
  for i := 0 ; i <= 11; i++ {
    fmt.Printf("%c", str[i]);
  }
}

