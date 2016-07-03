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
func programme_candidat(tableau1 []byte, taille1 int, tableau2 []byte, taille2 int) int{
  out0 := 0
  for i := 0; i < taille1; i++ {
      out0 += (int)(tableau1[i]) * i
      fmt.Printf("%c", tableau1[i])
  }
  fmt.Printf("--\n")
  for j := 0; j < taille2; j++ {
      out0 += (int)(tableau2[j]) * j * 100
      fmt.Printf("%c", tableau2[j])
  }
  fmt.Printf("--\n")
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille1 int
  fmt.Fscanf(reader, "%d", &taille1)
  skip()
  var tableau1 []byte = make([]byte, taille1)
  for a := 0; a < taille1; a++ {
      fmt.Fscanf(reader, "%c", &tableau1[a])
  }
  var taille2 int
  skip()
  fmt.Fscanf(reader, "%d", &taille2)
  skip()
  var tableau2 []byte = make([]byte, taille2)
  for b := 0; b < taille2; b++ {
      fmt.Fscanf(reader, "%c", &tableau2[b])
  }
  skip()
  fmt.Printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2))
}

