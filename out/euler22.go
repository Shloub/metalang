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
func score() int{
  skip()
  var len int
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var sum int = 0
  for i := 1 ; i <= len; i++ {
    var c byte
    fmt.Fscanf(reader, "%c", &c)
      sum += (int)(c) - (int)('A') + 1;
      /*		print c print " " print sum print " " */
  }
  return sum
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var sum int = 0
  var n int
  fmt.Fscanf(reader, "%d", &n)
  for i := 1 ; i <= n; i++ {
    sum += i * score();
  }
  fmt.Printf("%d\n", sum);
}

