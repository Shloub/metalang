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


func read_char_matrix(x int, y int) [][]byte{
  var tab [][]byte = make([][]byte, y)
  for z := 0 ; z <= y - 1; z++ {
    var b []byte = make([]byte, x)
      for c := 0 ; c <= x - 1; c++ {
        var d byte = '_'
          fmt.Fscanf(reader, "%c", &d);
          b[c] = d;
      }
      skip()
      var a []byte = b
      tab[z] = a;
  }
  return tab
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
  var f int = 0
  fmt.Fscanf(reader, "%d", &f);
  skip()
  var e int = f
  var taille_x int = e
  var h int = 0
  fmt.Fscanf(reader, "%d", &h);
  skip()
  var g int = h
  var taille_y int = g
  var tableau [][]byte = read_char_matrix(taille_x, taille_y)
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

