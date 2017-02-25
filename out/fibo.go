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
/*
La suite de fibonaci
*/
func fibo0(a int, b int, i int) int{
  out0 := 0
  a2 := a
  b2 := b
  for j := 0; j <= i + 1; j++ {
      out0 += a2
      tmp := b2
      b2 += a2
      a2 = tmp
  }
  return out0
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  a := 0
  b := 0
  i := 0
  fmt.Fscanf(reader, "%d", &a)
  skip()
  fmt.Fscanf(reader, "%d", &b)
  skip()
  fmt.Fscanf(reader, "%d", &i)
  fmt.Printf("%d", fibo0(a, b, i))
}

