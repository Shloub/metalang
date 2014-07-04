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
  var maximum int = 1
  _ = maximum
  var b0 int = 2
  var a int = 408464633
  for a != 1{
              var b int = b0
              var found bool = false
              for b * b < a{
                             if (a % b) == 0 {
                               a /= b;
                                 b0 = b;
                                 b = a;
                                 found = true;
                             }
                             b ++;
              }
              if !found {
                fmt.Printf("%d\n", a);
                  a = 1;
              }
  }
}

