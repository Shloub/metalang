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

func programme_candidat(tableau []int, taille int) int{
  var out_ int = 0
  for i := 0 ; i <= taille - 1; i++ {
    out_ += tableau[i];
  }
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b int = 0
  fmt.Fscanf(reader, "%d", &b);
  skip()
  var a int = b
  var taille int = a
  var d int = taille
  var e []int = make([]int, d)
  for f := 0 ; f <= d - 1; f++ {
    var g int = 0
      fmt.Fscanf(reader, "%d", &g);
      skip()
      e[f] = g;
  }
  var c []int = e
  var tableau []int = c
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

