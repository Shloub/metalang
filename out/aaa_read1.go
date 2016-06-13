package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var str []byte = make([]byte, 12)
  for a := 0; a < 12; a += 1 {
      fmt.Fscanf(reader, "%c", &str[a])
  }
  skip()
  for i := 0; i <= 11; i += 1 {
      fmt.Printf("%c", str[i])
  }
}

