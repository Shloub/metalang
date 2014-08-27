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


func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    var b []int = make([]int, x)
      for c := 0 ; c <= x - 1; c++ {
        var d int
        fmt.Fscanf(reader, "%d", &d)
          skip()
          b[c] = d;
      }
      var a []int = b
      tab[z] = a;
  }
  return tab
}

func programme_candidat(tableau [][]int, x int, y int) int{
  var out_ int = 0
  for i := 0 ; i <= y - 1; i++ {
    for j := 0 ; j <= x - 1; j++ {
        out_ += tableau[i][j] * (i * 2 + j);
      }
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
  var tableau [][]int = read_int_matrix(taille_x, taille_y)
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

