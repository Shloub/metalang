package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}



func read_int() int{
  var out_ int = 0
  fmt.Fscanf(reader, "%d", &out_);
  skip()
  return out_
}

func read_int_line(n int) []int{
  var tab []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var t_ int = 0
      fmt.Fscanf(reader, "%d", &t_);
      skip()
      tab[i] = t_;
  }
  return tab
}

func read_char_line(n int) []byte{
  var tab []byte = make([]byte, n)
  for i := 0 ; i <= n - 1; i++ {
    var t_ byte = '_'
      fmt.Fscanf(reader, "%c", &t_);
      tab[i] = t_;
  }
  skip()
  return tab
}

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = read_int()
  fmt.Printf("%d=len\n", len);
  var tab []int = read_int_line(len)
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>", i);
      var a int = tab[i]
      fmt.Printf("%d ", a);
  }
  fmt.Printf("\n");
  var tab2 []int = read_int_line(len)
  for i_ := 0 ; i_ <= len - 1; i_++ {
    fmt.Printf("%d==>", i_);
      var b int = tab2[i_]
      fmt.Printf("%d ", b);
  }
  var strlen int = read_int()
  fmt.Printf("%d=strlen\n", strlen);
  var tab4 []byte = read_char_line(strlen)
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
    var d byte = tab4[j]
      fmt.Printf("%c", d);
  }
}

