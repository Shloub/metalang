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
  var i int = 4
  /*while i < 10 do */
  fmt.Printf("%d", i);
  i ++;
  /*  end */
  fmt.Printf("%d", i);
}

