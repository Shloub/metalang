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

func position_alphabet(c byte) int{
  var i int = (int)(c)
  if i <= (int)('Z') && i >= (int)('A') {
    return i - (int)('A')
  } else if i <= (int)('z') && i >= (int)('a') {
    return i - (int)('a')
  } else {
    return -1
  } 
}

func of_position_alphabet(c int) byte{
  return (byte)(c + (int)('a'))
}

func crypte(taille_cle int, cle []byte, taille int, message []byte) {
  for i := 0 ; i <= taille - 1; i++ {
    var lettre int = position_alphabet(message[i])
      if lettre != -1 {
        var addon int = position_alphabet(cle[i % taille_cle])
          var new0 int = (addon + lettre) % 26
          message[i] = of_position_alphabet(new0);
      }
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var taille_cle int
  fmt.Fscanf(reader, "%d", &taille_cle)
  skip()
  var cle []byte = make([]byte, taille_cle)
  for index := 0 ; index <= taille_cle - 1; index++ {
    var out0 byte
    fmt.Fscanf(reader, "%c", &out0)
      cle[index] = out0;
  }
  skip()
  var taille int
  fmt.Fscanf(reader, "%d", &taille)
  skip()
  var message []byte = make([]byte, taille)
  for index2 := 0 ; index2 <= taille - 1; index2++ {
    var out2 byte
    fmt.Fscanf(reader, "%c", &out2)
      message[index2] = out2;
  }
  crypte(taille_cle, cle, taille, message);
  for i := 0 ; i <= taille - 1; i++ {
    fmt.Printf("%c", message[i]);
  }
  fmt.Printf("\n");
}

