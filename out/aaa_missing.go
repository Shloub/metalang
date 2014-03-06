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

/*
  Ce test a été généré par Metalang.
*/
func result(len int, tab []int) int{
  var tab2 []bool = make([]bool, len)
  for i := 0 ; i <= len - 1; i++ {
    tab2[i] = false;
  }
  for i1 := 0 ; i1 <= len - 1; i1++ {
    tab2[tab[i1]] = true;
  }
  for i2 := 0 ; i2 <= len - 1; i2++ {
    if !tab2[i2] {
        return i2
      }
  }
  return -1
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var l0 []int = read_int_line(1)
  var len int = l0[0]
  var tab []int = read_int_line(len)
  var a int = result(len, tab)
  fmt.Printf("%d", a);
}

