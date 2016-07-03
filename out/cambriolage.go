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
func max2_(a int, b int) int{
  if a > b {
      return a
  } else {
      return b
  }
}

func nbPassePartout(n int, passepartout [][]int, m int, serrures [][]int) int{
  max_ancient := 0
  max_recent := 0
  for i := 0; i < m; i++ {
      if serrures[i][0] == -1 && serrures[i][1] > max_ancient {
          max_ancient = serrures[i][1]
      }
      if serrures[i][0] == 1 && serrures[i][1] > max_recent {
          max_recent = serrures[i][1]
      }
  }
  max_ancient_pp := 0
  max_recent_pp := 0
  for i := 0; i < n; i++ {
      var pp []int = passepartout[i]
      if pp[0] >= max_ancient && pp[1] >= max_recent {
          return 1
      }
      max_ancient_pp = max2_(max_ancient_pp, pp[0])
      max_recent_pp = max2_(max_recent_pp, pp[1])
  }
  if max_ancient_pp >= max_ancient && max_recent_pp >= max_recent {
      return 2
  } else {
      return 0
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int
  fmt.Fscanf(reader, "%d", &n)
  skip()
  var passepartout [][]int = make([][]int, n)
  for i := 0; i < n; i++ {
      var out0 []int = make([]int, 2)
      for j := 0; j < 2; j++ {
          var out01 int
          fmt.Fscanf(reader, "%d", &out01)
          skip()
          out0[j] = out01
      }
      passepartout[i] = out0
  }
  var m int
  fmt.Fscanf(reader, "%d", &m)
  skip()
  var serrures [][]int = make([][]int, m)
  for k := 0; k < m; k++ {
      var out1 []int = make([]int, 2)
      for l := 0; l < 2; l++ {
          var out_ int
          fmt.Fscanf(reader, "%d", &out_)
          skip()
          out1[l] = out_
      }
      serrures[k] = out1
  }
  fmt.Printf("%d", nbPassePartout(n, passepartout, m, serrures))
}

