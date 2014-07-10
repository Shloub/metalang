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
    var b int = x
      var c []int = make([]int, b)
      for d := 0 ; d <= b - 1; d++ {
        var e int = 0
          fmt.Fscanf(reader, "%d", &e);
          skip()
          c[d] = e;
      }
      var a []int = c
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
  var g int = 0
  fmt.Fscanf(reader, "%d", &g);
  skip()
  var f int = g
  var taille_x int = f
  var k int = 0
  fmt.Fscanf(reader, "%d", &k);
  skip()
  var h int = k
  var taille_y int = h
  var tableau [][]int = read_int_matrix(taille_x, taille_y)
  fmt.Printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
}

