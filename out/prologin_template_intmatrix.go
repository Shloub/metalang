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
  out0 := 0
  for i := 0; i < y; i += 1 {
      for j := 0; j < x; j += 1 {
          out0 += tableau[i][j] * (i * 2 + j)
      }
  }
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille_y int
  var taille_x int
  fmt.Fscanf(reader, "%d", &taille_x)
  skip()
  fmt.Fscanf(reader, "%d", &taille_y)
  skip()
  var tableau [][]int = make([][]int, taille_y)
  for a := 0; a < taille_y; a += 1 {
      var b []int = make([]int, taille_x)
      for c := 0; c < taille_x; c += 1 {
          fmt.Fscanf(reader, "%d", &b[c])
          skip()
      }
      tableau[a] = b
  }
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y))
}

