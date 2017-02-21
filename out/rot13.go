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
/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/

func main() {
  reader = bufio.NewReader(os.Stdin)
  var strlen int
  fmt.Fscanf(reader, "%d", &strlen)
  skip()
  var tab4 []byte = make([]byte, strlen)
  for toto := 0; toto < strlen; toto++ {
      var tmpc byte
      fmt.Fscanf(reader, "%c", &tmpc)
      c := (int)(tmpc)
      if tmpc != ' ' {
          c = (c - (int)('a') + 13) % 26 + (int)('a')
      }
      tab4[toto] = (byte)(c)
  }
  for j := 0; j < strlen; j++ {
      fmt.Printf("%c", tab4[j])
  }
}

