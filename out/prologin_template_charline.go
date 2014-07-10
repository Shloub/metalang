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


func read_int() int{
  var out_ int = 0
  fmt.Fscanf(reader, "%d", &out_);
  skip()
  return out_
}

func read_char_line(n int) []byte{
  var tab []byte = make([]byte, n)
  for i := 0 ; i <= n - 1; i++ {
    var t byte = '_'
      fmt.Fscanf(reader, "%c", &t);
      tab[i] = t;
  }
  skip()
  return tab
}

func programme_candidat(tableau []byte, taille int) int{
  var out_ int = 0
  for i := 0 ; i <= taille - 1; i++ {
    out_ += (int)(tableau[i]) * i;
      fmt.Printf("%c", tableau[i]);
  }
  fmt.Printf("--\n");
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b int = 0
  fmt.Fscanf(reader, "%d", &b);
  skip()
  var a int = b
  var taille int = a
  var d int = taille
  var e []byte = make([]byte, d)
  for f := 0 ; f <= d - 1; f++ {
    var g byte = '_'
      fmt.Fscanf(reader, "%c", &g);
      e[f] = g;
  }
  skip()
  var c []byte = e
  var tableau []byte = c
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

