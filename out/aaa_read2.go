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
  fmt.Printf("%d=len\n", len);
  var tab []int = make([]int, len)
  for f := 0 ; f <= len - 1; f++ {
    fmt.Fscanf(reader, "%d", &tab[f])
      skip()
  }
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d ", i, tab[i]);
  }
  fmt.Printf("\n");
  var tab2 []int = make([]int, len)
  for l := 0 ; l <= len - 1; l++ {
    fmt.Fscanf(reader, "%d", &tab2[l])
      skip()
  }
  for i_ := 0 ; i_ <= len - 1; i_++ {
    fmt.Printf("%d==>%d ", i_, tab2[i_]);
  }
  var strlen int
  fmt.Fscanf(reader, "%d", &strlen)
  skip()
  fmt.Printf("%d=strlen\n", strlen);
  var tab4 []byte = make([]byte, strlen)
  for s := 0 ; s <= strlen - 1; s++ {
    fmt.Fscanf(reader, "%c", &tab4[s])
  }
  skip()
  for i3 := 0 ; i3 <= strlen - 1; i3++ {
    var tmpc byte = tab4[i3]
      var c int = (int)(tmpc)
      fmt.Printf("%c:%d ", tmpc, c);
      if tmpc != ' ' {
        c = ((c - (int)('a')) + 13) % 26 + (int)('a');
      }
      tab4[i3] = (byte)(c);
  }
  for j := 0 ; j <= strlen - 1; j++ {
    fmt.Printf("%c", tab4[j]);
  }
}

