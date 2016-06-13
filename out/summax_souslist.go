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
func summax(lst []int, len int) int{
  current := 0
  max0 := 0
  for i := 0; i < len; i += 1 {
      current += lst[i]
      if current < 0 {
          current = 0
      }
      if max0 < current {
          max0 = current
      }
  }
  return max0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  len := 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i := 0; i < len; i += 1 {
      tmp := 0
      fmt.Fscanf(reader, "%d", &tmp)
      skip()
      tab[i] = tmp
  }
  result := summax(tab, len)
  fmt.Printf("%d", result)
}

