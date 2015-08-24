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
  len *= 2;
  fmt.Printf("len*2=%d\n", len);
  len /= 2;
  var tab []int = make([]int, len)
  for i := 0 ; i < len; i++ {
    var tmpi1 int
    fmt.Fscanf(reader, "%d", &tmpi1)
      skip()
      fmt.Printf("%d=>%d ", i, tmpi1);
      tab[i] = tmpi1;
  }
  fmt.Printf("\n");
  var tab2 []int = make([]int, len)
  for i_ := 0 ; i_ < len; i_++ {
    var tmpi2 int
    fmt.Fscanf(reader, "%d", &tmpi2)
      skip()
      fmt.Printf("%d==>%d ", i_, tmpi2);
      tab2[i_] = tmpi2;
  }
  var strlen int
  fmt.Fscanf(reader, "%d", &strlen)
  skip()
  fmt.Printf("%d=strlen\n", strlen);
  var tab4 []byte = make([]byte, strlen)
  for toto := 0 ; toto < strlen; toto++ {
    var tmpc byte
    fmt.Fscanf(reader, "%c", &tmpc)
      var c int = (int)(tmpc)
      fmt.Printf("%c:%d ", tmpc, c);
      if tmpc != ' ' {
        c = (c - (int)('a') + 13) % 26 + (int)('a');
      }
      tab4[toto] = (byte)(c);
  }
  for j := 0 ; j < strlen; j++ {
    fmt.Printf("%c", tab4[j]);
  }
}

