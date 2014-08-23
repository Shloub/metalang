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


func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    var b []int = make([]int, x)
      for c := 0 ; c <= x - 1; c++ {
        var d int = 0
          fmt.Fscanf(reader, "%d", &d);
          skip()
          b[c] = d;
      }
      var a []int = b
      tab[z] = a;
  }
  return tab
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var f int = 0
  fmt.Fscanf(reader, "%d", &f);
  skip()
  var len int = f
  fmt.Printf("%d=len\n", len);
  var h []int = make([]int, len)
  for k := 0 ; k <= len - 1; k++ {
    var l int = 0
      fmt.Fscanf(reader, "%d", &l);
      skip()
      h[k] = l;
  }
  var tab1 []int = h
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>%d\n", i, tab1[i]);
  }
  var o int = 0
  fmt.Fscanf(reader, "%d", &o);
  skip()
  len = o;
  var tab2 [][]int = read_int_matrix(len, len - 1)
  for i := 0 ; i <= len - 2; i++ {
    for j := 0 ; j <= len - 1; j++ {
        fmt.Printf("%d ", tab2[i][j]);
      }
      fmt.Printf("\n");
  }
}

