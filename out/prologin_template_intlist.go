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

func programme_candidat(tableau []int, taille int) int{
  var out_ int = 0
  for i := 0 ; i <= taille - 1; i++ {
    out_ += tableau[i];
  }
  return out_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b int
  fmt.Fscanf(reader, "%d", &b)
  skip()
  var taille int = b
  var d []int = make([]int, taille)
  for e := 0 ; e <= taille - 1; e++ {
    fmt.Fscanf(reader, "%d", &d[e])
      skip()
  }
  var tableau []int = d
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

