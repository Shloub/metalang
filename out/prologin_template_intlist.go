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
  var d []int = make([]int, taille)
  for e := 0 ; e <= taille - 1; e++ {
    var f int = 0
      fmt.Fscanf(reader, "%d", &f);
      skip()
      d[e] = f;
  }
  var c []int = d
  var tableau []int = c
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

