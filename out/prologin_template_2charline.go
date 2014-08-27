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
  var b int
  fmt.Fscanf(reader, "%d", &b)
  skip()
  var taille1 int = b
  var d []byte = make([]byte, taille1)
  for e := 0 ; e <= taille1 - 1; e++ {
    var f byte
    fmt.Fscanf(reader, "%c", &f)
      d[e] = f;
  }
  skip()
  var tableau1 []byte = d
  var h int
  fmt.Fscanf(reader, "%d", &h)
  skip()
  var taille2 int = h
  var l []byte = make([]byte, taille2)
  for m := 0 ; m <= taille2 - 1; m++ {
    var o byte
    fmt.Fscanf(reader, "%c", &o)
      l[m] = o;
  }
  skip()
  var tableau2 []byte = l
  fmt.Printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
}

