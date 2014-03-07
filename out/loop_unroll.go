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

/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/
func main() {
  reader = bufio.NewReader(os.Stdin)
  var j int = 0
  j = 0;
  fmt.Printf("%d\n", j);
  j = 1;
  fmt.Printf("%d\n", j);
  j = 2;
  fmt.Printf("%d\n", j);
  j = 3;
  fmt.Printf("%d\n", j);
  j = 4;
  fmt.Printf("%d\n", j);
}

