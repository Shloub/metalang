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
  var b int = 5
  var a []int = make([]int, b)
  for i := 0 ; i <= b - 1; i++ {
    fmt.Printf("%d", i);
      a[i] = i * 2;
  }
}

