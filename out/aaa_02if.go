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


func f(i int) bool{
  if i == 0 {
    return true
  }
  return false
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  if f(4) {
    fmt.Printf("true <-\n ->\n");
  } else {
    fmt.Printf("false <-\n ->\n");
  }
  fmt.Printf("small test end\n");
}

