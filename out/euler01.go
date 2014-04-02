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
  var sum int = 0
  for i := 0 ; i <= 999; i++ {
    if (i % 3) == 0 || (i % 5) == 0 {
        sum += i;
      }
  }
  fmt.Printf("%d\n", sum);
}

