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
func montagnes0(tab []int, len int) int{
  max0 := 1
  j := 1
  i := len - 2
  for i >= 0 {
      x := tab[i]
      for j >= 0 && x > tab[len - j] {
          j -= 1
      }
      j += 1
      tab[len - j] = x
      if j > max0 {
          max0 = j
      }
      i -= 1
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
      x := 0
      fmt.Fscanf(reader, "%d", &x)
      skip()
      tab[i] = x
  }
  fmt.Printf("%d", montagnes0(tab, len))
}

