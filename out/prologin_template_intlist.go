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
  out0 := 0
  for i := 0; i < taille; i++ {
      out0 += tableau[i]
  }
  return out0
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille int
  fmt.Fscanf(reader, "%d", &taille)
  skip()
  var tableau []int = make([]int, taille)
  for a := 0; a < taille; a++ {
      fmt.Fscanf(reader, "%d", &tableau[a])
      skip()
  }
  fmt.Printf("%d\n", programme_candidat(tableau, taille))
}

