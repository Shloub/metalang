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



func sort_(tab []int, len int) {
  for i := 0 ; i <= len - 1; i++ {
    for j := i + 1 ; j <= len - 1; j++ {
        if tab[i] > tab[j] {
            var tmp int = tab[i]
              tab[i] = tab[j];
              tab[j] = tmp;
          }
      }
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 2
  fmt.Fscanf(reader, "%d", &len);
  skip()
  var tab []int = make([]int, len)
  for i_ := 0 ; i_ <= len - 1; i_++ {
    var tmp int = 0
      fmt.Fscanf(reader, "%d", &tmp);
      skip()
      tab[i_] = tmp;
  }
  sort_(tab, len);
  for i := 0 ; i <= len - 1; i++ {
    var a int = tab[i]
      fmt.Printf("%d", a);
  }
}

