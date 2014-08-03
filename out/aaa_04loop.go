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
  var j int = 0
  for k := 0 ; k <= 10; k++ {
    j += k;
      fmt.Printf("%d\n", j);
  }
  var i int = 4
  for i < 10{
              fmt.Printf("%d", i);
              i ++;
              j += i;
  }
  fmt.Printf("%d%d", j, i);
}

