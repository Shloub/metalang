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
  /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
  for a := 1 ; a <= 1000; a++ {
    for b := a + 1 ; b <= 1000; b++ {
        var c int = 1000 - a - b
          var a2b2 int = a * a + b * b
          var cc int = c * c
          if cc == a2b2 && c > a {
            fmt.Printf("%d\n%d\n%d\n", a, b, c);
              var d int = a * b * c
              fmt.Printf("%d\n", d);
          }
      }
  }
}

