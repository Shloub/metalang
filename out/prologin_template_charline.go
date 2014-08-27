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
  var b int
  fmt.Fscanf(reader, "%d", &b)
  skip()
  var taille int = b
  var d []byte = make([]byte, taille)
  for e := 0 ; e <= taille - 1; e++ {
    var f byte
    fmt.Fscanf(reader, "%c", &f)
      d[e] = f;
  }
  skip()
  var tableau []byte = d
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

