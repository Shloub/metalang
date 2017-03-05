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
  var len int
  skip()
  fmt.Fscanf(reader, "%d", &len)
  skip()
  sum := 0
  for i := 1; i <= len; i++ {
      var c byte
      fmt.Fscanf(reader, "%c", &c)
      sum += (int)(c) - (int)('A') + 1
      /*		print c print " " print sum print " " */
  }
  return sum
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  sum := 0
  var n int
  fmt.Fscanf(reader, "%d", &n)
  for i := 1; i <= n; i++ {
      sum += i * score()
  }
  fmt.Printf("%d\n", sum)
}

