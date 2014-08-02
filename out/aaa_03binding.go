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


func g(i int) int{
  var j int = i * 4
  if (j % 2) == 1 {
    return 0
  }
  return j
}

func h(i int) {
  fmt.Printf("%d\n", i);
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  h(14);
  var a int = 4
  var b int = 5
  fmt.Printf("%d", a + b);
  /* main */
  h(15);
  a = 2;
  b = 1;
  fmt.Printf("%d", a + b);
}

