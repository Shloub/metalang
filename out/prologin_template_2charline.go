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

func programme_candidat(tableau1 []byte, taille1 int, tableau2 []byte, taille2 int) int{
  var out_ int = 0
  for i := 0 ; i <= taille1 - 1; i++ {
    out_ += (int)(tableau1[i]) * i;
      fmt.Printf("%c", tableau1[i]);
  }
  fmt.Printf("--\n");
  for j := 0 ; j <= taille2 - 1; j++ {
    out_ += (int)(tableau2[j]) * j * 100;
      fmt.Printf("%c", tableau2[j]);
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
  var taille1 int = a
  var d int = taille1
  var e []byte = make([]byte, d)
  for f := 0 ; f <= d - 1; f++ {
    var g byte = '_'
      fmt.Fscanf(reader, "%c", &g);
      e[f] = g;
  }
  skip()
  var c []byte = e
  var tableau1 []byte = c
  var k int = 0
  fmt.Fscanf(reader, "%d", &k);
  skip()
  var h int = k
  var taille2 int = h
  var m int = taille2
  var o []byte = make([]byte, m)
  for p := 0 ; p <= m - 1; p++ {
    var q byte = '_'
      fmt.Fscanf(reader, "%c", &q);
      o[p] = q;
  }
  skip()
  var l []byte = o
  var tableau2 []byte = l
  fmt.Printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
}

