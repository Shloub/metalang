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


func summax(lst []int, len int) int{
  var current int = 0
  var max_ int = 0
  for i := 0 ; i <= len - 1; i++ {
    current += lst[i];
      if current < 0 {
        current = 0;
      }
      if max_ < current {
        max_ = current;
      }
  }
  return max_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
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
  var result int = summax(tab, len)
  fmt.Printf("%d", result);
}

