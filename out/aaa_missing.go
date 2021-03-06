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
/*
  Ce test a été généré par Metalang.
*/
func result(len int, tab []int) int{
  var tab2 []bool = make([]bool, len)
  for i := 0; i < len; i++ {
      tab2[i] = false
  }
  for i1 := 0; i1 < len; i1++ {
      fmt.Printf("%d ", tab[i1])
      tab2[tab[i1]] = true
  }
  fmt.Printf("\n")
  for i2 := 0; i2 < len; i2++ {
      if !tab2[i2] {
          return i2
      }
  }
  return -1
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int
  fmt.Fscanf(reader, "%d", &len)
  skip()
  fmt.Printf("%d\n", len)
  var tab []int = make([]int, len)
  for a := 0; a < len; a++ {
      fmt.Fscanf(reader, "%d", &tab[a])
      skip()
  }
  fmt.Printf("%d\n", result(len, tab))
}

