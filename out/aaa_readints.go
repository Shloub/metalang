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

func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    skip()
      tab[z] = read_int_line(x);
  }
  return tab
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = read_int()
  fmt.Printf("%d=len\n", len);
  var tab1 []int = read_int_line(len)
  for i := 0 ; i <= len - 1; i++ {
    fmt.Printf("%d=>", i);
      var a int = tab1[i]
      fmt.Printf("%d\n", a);
  }
  len = read_int();
  var tab2 [][]int = read_int_matrix(len, len - 1)
  for i := 0 ; i <= len - 2; i++ {
    for j := 0 ; j <= len - 1; j++ {
        var b int = tab2[i][j]
          fmt.Printf("%d ", b);
      }
      fmt.Printf("\n");
  }
}

