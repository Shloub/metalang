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


func montagnes_(tab []int, len int) int{
  var max_ int = 1
  var j int = 1
  var i int = len - 2
  for i >= 0{
              var x int = tab[i]
              for j >= 0 && x > tab[len - j]{
                                              j --;
              }
              j ++;
              tab[len - j] = x;
              if j > max_ {
                max_ = j;
              }
              i --;
  }
  return max_
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var x int = 0
      fmt.Fscanf(reader, "%d", &x)
      skip()
      tab[i] = x;
  }
  fmt.Printf("%d", montagnes_(tab, len));
}

