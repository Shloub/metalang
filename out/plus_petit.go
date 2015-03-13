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
func go0(tab []int, a int, b int) int{
  var m int = (a + b) / 2
  if a == m {
    if tab[a] == m {
        return b
      } else {
        return a
      }
  }
  var i int = a
  var j int = b
  for i < j{
    var e int = tab[i]
    if e < m {
      i ++;
    } else {
      j --;
      tab[i] = tab[j];
      tab[j] = e;
    }
  }
  if i < m {
    return go0(tab, a, m)
  } else {
    return go0(tab, m, b)
  }
}

func plus_petit0(tab []int, len int) int{
  return go0(tab, 0, len)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var tmp int = 0
      fmt.Fscanf(reader, "%d", &tmp)
      skip()
      tab[i] = tmp;
  }
  fmt.Printf("%d", plus_petit0(tab, len));
}

