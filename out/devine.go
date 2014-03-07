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


func devine_(nombre int, tab []int, len int) bool{
  var min_ int = tab[0]
  var max_ int = tab[1]
  for i := 2 ; i <= len - 1; i++ {
    if tab[i] > max_ || tab[i] < min_ {
        return false
      }
      if tab[i] < nombre {
        min_ = tab[i];
      }
      if tab[i] > nombre {
        max_ = tab[i];
      }
      if tab[i] == nombre && len != i + 1 {
        return false
      }
  }
  return true
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var nombre int = 0
  fmt.Fscanf(reader, "%d", &nombre);
  skip()
  var len int = 0
  fmt.Fscanf(reader, "%d", &len);
  skip()
  var tab []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var tmp int = 0
      fmt.Fscanf(reader, "%d", &tmp);
      skip()
      tab[i] = tmp;
  }
  var a bool = devine_(nombre, tab, len)
  if a {
    fmt.Printf("True");
  } else {
    fmt.Printf("False");
  }
}

