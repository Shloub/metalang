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
  var i int = 0
  i --;
  fmt.Printf("%d", i);
  i += 55;
  fmt.Printf("%d", i);
  i *= 13;
  fmt.Printf("%d", i);
  i /= 2;
  fmt.Printf("%d", i);
  i ++;
  fmt.Printf("%d", i);
  i /= 3;
  fmt.Printf("%d", i);
  i --;
  fmt.Printf("%d", i);
}

