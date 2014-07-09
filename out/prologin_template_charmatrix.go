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

func read_char_matrix(x int, y int) [][]byte{
  var tab [][]byte = make([][]byte, y)
  for z := 0 ; z <= y - 1; z++ {
    tab[z] = read_char_line(x);
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
  var taille_x int = read_int()
  var taille_y int = read_int()
  var tableau [][]byte = read_char_matrix(taille_x, taille_y)
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

