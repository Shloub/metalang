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

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  for i := 1 ; i <= 3; i++ {
    var d int
    fmt.Fscanf(reader, "%d", &d)
      skip()
      var e int
      fmt.Fscanf(reader, "%d", &e)
      skip()
      var f * tuple_int_int = new (tuple_int_int)
      (*f).tuple_int_int_field_0=d
      (*f).tuple_int_int_field_1=e
      var a int = (*f).tuple_int_int_field_0
      var b int = (*f).tuple_int_int_field_1
      fmt.Printf("a = %d b = %d\n", a, b);
  }
}

