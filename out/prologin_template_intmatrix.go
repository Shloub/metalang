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

func programme_candidat(tableau [][]int, x int, y int) int{
  var out0 int = 0
  for i := 0 ; i <= y - 1; i++ {
    for j := 0 ; j <= x - 1; j++ {
        out0 += tableau[i][j] * (i * 2 + j);
      }
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
  var tableau [][]int = make([][]int, taille_y)
  for a := 0 ; a <= taille_y - 1; a++ {
    var b []int = make([]int, taille_x)
      for c := 0 ; c <= taille_x - 1; c++ {
        fmt.Fscanf(reader, "%d", &b[c])
          skip()
      }
      tableau[a] = b;
  }
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

