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
  var out0 int = 0
  for i := 0 ; i < taille_y; i++ {
    for j := 0 ; j < taille_x; j++ {
        out0 += (int)(tableau[i][j]) * (i + j * 2);
          fmt.Printf("%c", tableau[i][j]);
      }
      fmt.Printf("--\n");
  }
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille_x int
  fmt.Fscanf(reader, "%d", &taille_x)
  skip()
  var taille_y int
  fmt.Fscanf(reader, "%d", &taille_y)
  skip()
  var a [][]byte = make([][]byte, taille_y)
  for b := 0 ; b < taille_y; b++ {
    var c []byte = make([]byte, taille_x)
      for d := 0 ; d < taille_x; d++ {
        fmt.Fscanf(reader, "%c", &c[d])
      }
      skip()
      a[b] = c;
  }
  var tableau [][]byte = a
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

