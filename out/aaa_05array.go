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


func id(b []bool) []bool{
  return b
}

func g(t []bool, index int) {
  t[index] = false;
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var a []bool = make([]bool, 5)
  for i := 0 ; i <= 5 - 1; i++ {
    fmt.Printf("%d", i);
      a[i] = (i % 2) == 0;
  }
  var c bool = a[0]
  if c {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
  g(id(a), 0);
  var d bool = a[0]
  if d {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
  fmt.Printf("\n");
}

