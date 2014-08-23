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
  var b int = 0
  fmt.Fscanf(reader, "%d", &b);
  skip()
  var len int = b
  fmt.Printf("%d\n", len);
  var d []int = make([]int, len)
  for e := 0 ; e <= len - 1; e++ {
    var f int = 0
      fmt.Fscanf(reader, "%d", &f);
      skip()
      d[e] = f;
  }
  var tab []int = d
  fmt.Printf("%d", result(len, tab));
}

