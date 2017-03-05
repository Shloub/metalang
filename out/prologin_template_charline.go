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
func programme_candidat(tableau []byte, taille int) int{
  out0 := 0
  for i := 0; i < taille; i++ {
      out0 += (int)(tableau[i]) * i
      fmt.Printf("%c", tableau[i])
  }
  fmt.Printf("--\n")
  return out0
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille int
  fmt.Fscanf(reader, "%d", &taille)
  skip()
  var tableau []byte = make([]byte, taille)
  for a := 0; a < taille; a++ {
      fmt.Fscanf(reader, "%c", &tableau[a])
  }
  skip()
  fmt.Printf("%d\n", programme_candidat(tableau, taille))
}

