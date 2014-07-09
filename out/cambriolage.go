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


func max2(a int, b int) int{
  if a > b {
    return a
  } else {
    return b
  }
}

func nbPassePartout(n int, passepartout [][]int, m int, serrures [][]int) int{
  var max_ancient int = 0
  var max_recent int = 0
  for i := 0 ; i <= m - 1; i++ {
    if serrures[i][0] == -1 && serrures[i][1] > max_ancient {
        max_ancient = serrures[i][1];
      }
      if serrures[i][0] == 1 && serrures[i][1] > max_recent {
        max_recent = serrures[i][1];
      }
  }
  var max_ancient_pp int = 0
  var max_recent_pp int = 0
  for i := 0 ; i <= n - 1; i++ {
    var pp []int = passepartout[i]
      if pp[0] >= max_ancient && pp[1] >= max_recent {
        return 1
      }
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
  }
  if max_ancient_pp >= max_ancient && max_recent_pp >= max_recent {
    return 2
  } else {
    return 0
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int = 0
  fmt.Fscanf(reader, "%d", &n);
  skip()
  var passepartout [][]int = make([][]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var c int = 2
      var out0 []int = make([]int, c)
      for j := 0 ; j <= c - 1; j++ {
        var out__ int = 0
          fmt.Fscanf(reader, "%d", &out__);
          skip()
          out0[j] = out__;
      }
      passepartout[i] = out0;
  }
  var m int = 0
  fmt.Fscanf(reader, "%d", &m);
  skip()
  var serrures [][]int = make([][]int, m)
  for k := 0 ; k <= m - 1; k++ {
    var d int = 2
      var out1 []int = make([]int, d)
      for l := 0 ; l <= d - 1; l++ {
        var out_ int = 0
          fmt.Fscanf(reader, "%d", &out_);
          skip()
          out1[l] = out_;
      }
      serrures[k] = out1;
  }
  fmt.Printf("%d", nbPassePartout(n, passepartout, m, serrures));
}

