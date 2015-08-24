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
func pathfind_aux(cache []int, tab []int, len int, pos int) int{
  if pos >= len - 1 {
    return 0
  } else if cache[pos] != -1 {
    return cache[pos]
  } else {
    cache[pos] = len * 2;
    var posval int = pathfind_aux(cache, tab, len, tab[pos])
    var oneval int = pathfind_aux(cache, tab, len, pos + 1)
    var out0 int = 0
    if posval < oneval {
      out0 = 1 + posval;
    } else {
      out0 = 1 + oneval;
    }
    cache[pos] = out0;
    return out0
  } 
}

func pathfind(tab []int, len int) int{
  var cache []int = make([]int, len)
  for i := 0 ; i < len; i++ {
    cache[i] = -1;
  }
  return pathfind_aux(cache, tab, len, 0)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i := 0 ; i < len; i++ {
    var tmp int = 0
      fmt.Fscanf(reader, "%d", &tmp)
      skip()
      tab[i] = tmp;
  }
  var result int = pathfind(tab, len)
  fmt.Printf("%d", result);
}

