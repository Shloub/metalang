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
  var a int = 1
  var b int = 2
  var sum int = 0
  for a < 4000000{
                   if (a % 2) == 0 {
                     sum += a;
                   }
                   var c int = a
                   a = b;
                   b += c;
  }
  fmt.Printf("%d\n", sum);
}

