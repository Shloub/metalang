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

func find(n int, m [][]int, x int, y int, dx int, dy int) int{
  if x < 0 || x == 20 || y < 0 || y == 20 {
    return -1
  } else if n == 0 {
    return 1
  } else {
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy)
  } 
}


type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var directions []* tuple_int_int = make([]* tuple_int_int, 8)
  for i := 0 ; i <= 8 - 1; i++ {
    if i == 0 {
        var bh * tuple_int_int = new (tuple_int_int)
          (*bh).tuple_int_int_field_0=0
          (*bh).tuple_int_int_field_1=1
          directions[i] = bh;
      } else if i == 1 {
        var bg * tuple_int_int = new (tuple_int_int)
          (*bg).tuple_int_int_field_0=1
          (*bg).tuple_int_int_field_1=0
          directions[i] = bg;
      } else if i == 2 {
        var bf * tuple_int_int = new (tuple_int_int)
          (*bf).tuple_int_int_field_0=0
          (*bf).tuple_int_int_field_1=-1
          directions[i] = bf;
      } else if i == 3 {
        var be * tuple_int_int = new (tuple_int_int)
          (*be).tuple_int_int_field_0=-1
          (*be).tuple_int_int_field_1=0
          directions[i] = be;
      } else if i == 4 {
        var bd * tuple_int_int = new (tuple_int_int)
          (*bd).tuple_int_int_field_0=1
          (*bd).tuple_int_int_field_1=1
          directions[i] = bd;
      } else if i == 5 {
        var bc * tuple_int_int = new (tuple_int_int)
          (*bc).tuple_int_int_field_0=1
          (*bc).tuple_int_int_field_1=-1
          directions[i] = bc;
      } else if i == 6 {
        var bb * tuple_int_int = new (tuple_int_int)
          (*bb).tuple_int_int_field_0=-1
          (*bb).tuple_int_int_field_1=1
          directions[i] = bb;
      } else {
        var ba * tuple_int_int = new (tuple_int_int)
        (*ba).tuple_int_int_field_0=-1
        (*ba).tuple_int_int_field_1=-1
        directions[i] = ba;
      }      
  }
  var max0 int = 0
  var h int = 20
  var l [][]int = make([][]int, 20)
  for o := 0 ; o <= 20 - 1; o++ {
    var p []int = make([]int, h)
      for q := 0 ; q <= h - 1; q++ {
        var r int
        fmt.Fscanf(reader, "%d", &r)
          skip()
          p[q] = r;
      }
      l[o] = p;
  }
  var m [][]int = l
  for j := 0 ; j <= 7; j++ {
    var w * tuple_int_int = directions[j]
      var dx int = (*w).tuple_int_int_field_0
      var dy int = (*w).tuple_int_int_field_1
      for x := 0 ; x <= 19; x++ {
        for y := 0 ; y <= 19; y++ {
            var v int = find(4, m, x, y, dx, dy)
              var u int = max2_(max0, v)
              max0 = u;
          }
      }
  }
  fmt.Printf("%d\n", max0);
}

