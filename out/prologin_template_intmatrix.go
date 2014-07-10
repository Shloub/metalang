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
    var b []int = make([]int, x)
      for c := 0 ; c <= x - 1; c++ {
        var d int = 0
          fmt.Fscanf(reader, "%d", &d);
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
  var tableau [][]int = read_int_matrix(taille_x, taille_y)
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}
