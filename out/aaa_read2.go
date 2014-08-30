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
  var b int
  fmt.Fscanf(reader, "%d", &b)
  skip()
  var len int = b
  fmt.Printf("%d=len\n", len);
  var e []int = make([]int, len)
  for f := 0 ; f <= len - 1; f++ {
    fmt.Fscanf(reader, "%d", &e[f])
      skip()
  }
  var tab []int = e
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d ", i, tab[i]);
  }
  fmt.Printf("\n");
  var k []int = make([]int, len)
  for l := 0 ; l <= len - 1; l++ {
    fmt.Fscanf(reader, "%d", &k[l])
      skip()
  }
  var tab2 []int = k
  for i_ := 0 ; i_ <= len - 1; i_++ {
    fmt.Printf("%d==>%d ", i_, tab2[i_]);
  }
  var p int
  fmt.Fscanf(reader, "%d", &p)
  skip()
  var strlen int = p
  fmt.Printf("%d=strlen\n", strlen);
  var r []byte = make([]byte, strlen)
  for s := 0 ; s <= strlen - 1; s++ {
    fmt.Fscanf(reader, "%c", &r[s])
  }
  skip()
  var tab4 []byte = r
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

