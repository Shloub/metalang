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

func read_int_line(n int) []int{
  var tab []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var t int = 0
      fmt.Fscanf(reader, "%d", &t);
      skip()
      tab[i] = t;
  }
  return tab
}

func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    tab[z] = read_int_line(x);
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
  var taille_x int = read_int()
  var taille_y int = read_int()
  var tableau [][]int = read_int_matrix(taille_x, taille_y)
  var a int = programme_candidat(tableau, taille_x, taille_y)
  fmt.Printf("%d\n", a);
}

