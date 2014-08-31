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

func programme_candidat(tableau [][]byte, taille_x int, taille_y int) int{
  var out_ int = 0
  for i := 0 ; i <= taille_y - 1; i++ {
    for j := 0 ; j <= taille_x - 1; j++ {
        out_ += (int)(tableau[i][j]) * (i + j * 2);
          fmt.Printf("%c", tableau[i][j]);
      }
      fmt.Printf("--\n");
  }
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var f int
  fmt.Fscanf(reader, "%d", &f)
  skip()
  var taille_x int = f
  var h int
  fmt.Fscanf(reader, "%d", &h)
  skip()
  var taille_y int = h
  var l [][]byte = make([][]byte, taille_y)
  for m := 0 ; m <= taille_y - 1; m++ {
    var o []byte = make([]byte, taille_x)
      for p := 0 ; p <= taille_x - 1; p++ {
        var q byte
        fmt.Fscanf(reader, "%c", &q)
          o[p] = q;
      }
      skip()
      l[m] = o;
  }
  var tableau [][]byte = l
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

