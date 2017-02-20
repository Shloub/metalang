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
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int
  fmt.Fscanf(reader, "%d", &len)
  skip()
  fmt.Printf("%d=len\n", len)
  var tab []int = make([]int, len)
  for a := 0; a < len; a++ {
      fmt.Fscanf(reader, "%d", &tab[a])
      skip()
  }
  for i := 0; i < len; i++ {
      fmt.Printf("%d=>%d ", i, tab[i])
  }
  fmt.Printf("\n")
  var tab2 []int = make([]int, len)
  for b := 0; b < len; b++ {
      fmt.Fscanf(reader, "%d", &tab2[b])
      skip()
  }
  for i_ := 0; i_ < len; i_++ {
      fmt.Printf("%d==>%d ", i_, tab2[i_])
  }
  var strlen int
  fmt.Fscanf(reader, "%d", &strlen)
  skip()
  fmt.Printf("%d=strlen\n", strlen)
  var tab4 []byte = make([]byte, strlen)
  for d := 0; d < strlen; d++ {
      fmt.Fscanf(reader, "%c", &tab4[d])
  }
  skip()
  for i3 := 0; i3 < strlen; i3++ {
      var tmpc byte = tab4[i3]
      c := (int)(tmpc)
      fmt.Printf("%c:%d ", tmpc, c)
      if tmpc != ' ' {
          c = (c - (int)('a') + 13) % 26 + (int)('a')
      }
      tab4[i3] = (byte)(c)
  }
  for j := 0; j < strlen; j++ {
      fmt.Printf("%c", tab4[j])
  }
}

