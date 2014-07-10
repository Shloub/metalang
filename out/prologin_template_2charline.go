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
  var d []byte = make([]byte, taille1)
  for e := 0 ; e <= taille1 - 1; e++ {
    var f byte = '_'
      fmt.Fscanf(reader, "%c", &f);
      d[e] = f;
  }
  skip()
  var c []byte = d
  var tableau1 []byte = c
  var h int = 0
  fmt.Fscanf(reader, "%d", &h);
  skip()
  var g int = h
  var taille2 int = g
  var l []byte = make([]byte, taille2)
  for m := 0 ; m <= taille2 - 1; m++ {
    var o byte = '_'
      fmt.Fscanf(reader, "%c", &o);
      l[m] = o;
  }
  skip()
  var k []byte = l
  var tableau2 []byte = k
  fmt.Printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
}

