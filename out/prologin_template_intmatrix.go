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
  var f int
  fmt.Fscanf(reader, "%d", &f)
  skip()
  var taille_x int = f
  var h int
  fmt.Fscanf(reader, "%d", &h)
  skip()
  var taille_y int = h
  var l [][]int = make([][]int, taille_y)
  for m := 0 ; m <= taille_y - 1; m++ {
    var o []int = make([]int, taille_x)
      for p := 0 ; p <= taille_x - 1; p++ {
        var q int
        fmt.Fscanf(reader, "%d", &q)
          skip()
          o[p] = q;
      }
      l[m] = o;
  }
  var tableau [][]int = l
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

