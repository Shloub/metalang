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
func devine0(nombre int, tab []int, len int) bool{
  min0 := tab[0]
  max0 := tab[1]
  for i := 2; i < len; i += 1 {
      if tab[i] > max0 || tab[i] < min0 {
          return false
      }
      if tab[i] < nombre {
          min0 = tab[i]
      }
      if tab[i] > nombre {
          max0 = tab[i]
      }
      if tab[i] == nombre && len != i + 1 {
          return false
      }
  }
  return true
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int
  var nombre int
  fmt.Fscanf(reader, "%d", &nombre)
  skip()
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i := 0; i < len; i += 1 {
      var tmp int
      fmt.Fscanf(reader, "%d", &tmp)
      skip()
      tab[i] = tmp
  }
  if devine0(nombre, tab, len) {
      fmt.Printf("True")
  }else {
      fmt.Printf("False")
  }
}

