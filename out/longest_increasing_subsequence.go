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
func dichofind(len int, tab []int, tofind int, a int, b int) int{
  if a >= b - 1 {
      return a
  } else {
      c := (a + b) / 2
      if tab[c] < tofind {
          return dichofind(len, tab, tofind, c, b)
      } else {
          return dichofind(len, tab, tofind, a, c)
      }
  }
}
func process(len int, tab []int) int{
  var size []int = make([]int, len)
  for j := 0; j < len; j++ {
      if j == 0 {
          size[j] = 0
      } else {
          size[j] = len * 2
      }
  }
  for i := 0; i < len; i++ {
      k := dichofind(len, size, tab[i], 0, len - 1)
      if size[k + 1] > tab[i] {
          size[k + 1] = tab[i]
      }
  }
  for l := 0; l < len; l++ {
      fmt.Printf("%d ", size[l])
  }
  for m := 0; m < len; m++ {
      k := len - 1 - m
      if size[k] != len * 2 {
          return k
      }
  }
  return 0
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int
  fmt.Fscanf(reader, "%d", &n)
  skip()
  for i := 1; i <= n; i++ {
      var len int
      fmt.Fscanf(reader, "%d", &len)
      skip()
      var d []int = make([]int, len)
      for e := 0; e < len; e++ {
          fmt.Fscanf(reader, "%d", &d[e])
          skip()
      }
      fmt.Printf("%d\n", process(len, d))
  }
}

