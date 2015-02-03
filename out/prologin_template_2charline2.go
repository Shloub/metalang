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
  var out0 int = 0
  for i := 0 ; i <= taille1 - 1; i++ {
    out0 += (int)(tableau1[i]) * i;
      fmt.Printf("%c", tableau1[i]);
  }
  fmt.Printf("--\n");
  for j := 0 ; j <= taille2 - 1; j++ {
    out0 += (int)(tableau2[j]) * j * 100;
      fmt.Printf("%c", tableau2[j]);
  }
  fmt.Printf("--\n");
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille1 int
  fmt.Fscanf(reader, "%d", &taille1)
  skip()
  var taille2 int
  fmt.Fscanf(reader, "%d", &taille2)
  skip()
  var tableau1 []byte = make([]byte, taille1)
  for g := 0 ; g <= taille1 - 1; g++ {
    fmt.Fscanf(reader, "%c", &tableau1[g])
  }
  skip()
  var tableau2 []byte = make([]byte, taille2)
  for m := 0 ; m <= taille2 - 1; m++ {
    fmt.Fscanf(reader, "%c", &tableau2[m])
  }
  skip()
  fmt.Printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
}

