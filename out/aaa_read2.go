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
    var t int = 0
      fmt.Fscanf(reader, "%d", &t);
      skip()
      tab[i] = t;
  }
  return tab
}

func read_char_line(n int) []byte{
  var tab []byte = make([]byte, n)
  for i := 0 ; i <= n - 1; i++ {
    var t byte = '_'
      fmt.Fscanf(reader, "%c", &t);
      tab[i] = t;
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
  var b int = 0
  fmt.Fscanf(reader, "%d", &b);
  skip()
  var a int = b
  var len int = a
  fmt.Printf("%d=len\n", len);
  var e int = len
  var f []int = make([]int, e)
  for g := 0 ; g <= e - 1; g++ {
    var h int = 0
      fmt.Fscanf(reader, "%d", &h);
      skip()
      f[g] = h;
  }
  var d []int = f
  var tab []int = d
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d ", i, tab[i]);
  }
  fmt.Printf("\n");
  var l int = len
  var m []int = make([]int, l)
  for o := 0 ; o <= l - 1; o++ {
    var p int = 0
      fmt.Fscanf(reader, "%d", &p);
      skip()
      m[o] = p;
  }
  var k []int = m
  var tab2 []int = k
  for i_ := 0 ; i_ <= len - 1; i_++ {
    fmt.Printf("%d==>%d ", i_, tab2[i_]);
  }
  var r int = 0
  fmt.Fscanf(reader, "%d", &r);
  skip()
  var q int = r
  var strlen int = q
  fmt.Printf("%d=strlen\n", strlen);
  var u int = strlen
  var v []byte = make([]byte, u)
  for w := 0 ; w <= u - 1; w++ {
    var x byte = '_'
      fmt.Fscanf(reader, "%c", &x);
      v[w] = x;
  }
  skip()
  var s []byte = v
  var tab4 []byte = s
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

