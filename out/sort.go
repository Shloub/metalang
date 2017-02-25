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
func copytab(tab []int, len int) []int{
  var o []int = make([]int, len)
  for i := 0; i < len; i++ {
      o[i] = tab[i]
  }
  return o
}
func bubblesort(tab []int, len int) {
  for i := 0; i < len; i++ {
      for j := i + 1; j < len; j++ {
          if tab[i] > tab[j] {
              tmp := tab[i]
              tab[i] = tab[j]
              tab[j] = tmp
          }
      }
  }
}
func qsort0(tab []int, len int, i int, j int) {
  if i < j {
      i0 := i
      j0 := j
      /* pivot : tab[0] */
      for i != j {
          if tab[i] > tab[j] {
              if i == j - 1 {
                  /* on inverse simplement*/
                  tmp := tab[i]
                  tab[i] = tab[j]
                  tab[j] = tmp
                  i++
              } else {
                  /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
                  tmp := tab[i]
                  tab[i] = tab[j]
                  tab[j] = tab[i + 1]
                  tab[i + 1] = tmp
                  i++
              }
          } else {
              j--
          }
      }
      qsort0(tab, len, i0, i - 1)
      qsort0(tab, len, i + 1, j0)
  }
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  len := 2
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []int = make([]int, len)
  for i_ := 0; i_ < len; i_++ {
      tmp := 0
      fmt.Fscanf(reader, "%d", &tmp)
      skip()
      tab[i_] = tmp
  }
  var tab2 []int = copytab(tab, len)
  bubblesort(tab2, len)
  for i := 0; i < len; i++ {
      fmt.Printf("%d ", tab2[i])
  }
  fmt.Printf("\n")
  var tab3 []int = copytab(tab, len)
  qsort0(tab3, len, 0, len - 1)
  for i := 0; i < len; i++ {
      fmt.Printf("%d ", tab3[i])
  }
  fmt.Printf("\n")
}

