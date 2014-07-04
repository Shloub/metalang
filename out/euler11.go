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

func read_int_line(n int) []int{
  var tab []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var t int = 0
      fmt.Fscanf(reader, "%d", &t);
      skip()
      tab[i] = t;
  }
  return tab
}

func read_int_matrix(x int, y int) [][]int{
  var tab [][]int = make([][]int, y)
  for z := 0 ; z <= y - 1; z++ {
    tab[z] = read_int_line(x);
  }
  return tab
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
  var c int = 8
  var directions []* tuple_int_int = make([]* tuple_int_int, c)
  for i := 0 ; i <= c - 1; i++ {
    if i == 0 {
        var p * tuple_int_int = new (tuple_int_int)
          (*p).tuple_int_int_field_0=0;
          (*p).tuple_int_int_field_1=1;
          directions[i] = p;
      } else if i == 1 {
        var o * tuple_int_int = new (tuple_int_int)
          (*o).tuple_int_int_field_0=1;
          (*o).tuple_int_int_field_1=0;
          directions[i] = o;
      } else if i == 2 {
        var l * tuple_int_int = new (tuple_int_int)
          (*l).tuple_int_int_field_0=0;
          (*l).tuple_int_int_field_1=-1;
          directions[i] = l;
      } else if i == 3 {
        var k * tuple_int_int = new (tuple_int_int)
          (*k).tuple_int_int_field_0=-1;
          (*k).tuple_int_int_field_1=0;
          directions[i] = k;
      } else if i == 4 {
        var h * tuple_int_int = new (tuple_int_int)
          (*h).tuple_int_int_field_0=1;
          (*h).tuple_int_int_field_1=1;
          directions[i] = h;
      } else if i == 5 {
        var g * tuple_int_int = new (tuple_int_int)
          (*g).tuple_int_int_field_0=1;
          (*g).tuple_int_int_field_1=-1;
          directions[i] = g;
      } else if i == 6 {
        var f * tuple_int_int = new (tuple_int_int)
          (*f).tuple_int_int_field_0=-1;
          (*f).tuple_int_int_field_1=1;
          directions[i] = f;
      } else {
        var e * tuple_int_int = new (tuple_int_int)
        (*e).tuple_int_int_field_0=-1;
        (*e).tuple_int_int_field_1=-1;
        directions[i] = e;
      }      
  }
  var max_ int = 0
  var m [][]int = read_int_matrix(20, 20)
  for j := 0 ; j <= 7; j++ {
    var d * tuple_int_int = directions[j]
      var dx int = (*d).tuple_int_int_field_0
      var dy int = (*d).tuple_int_int_field_1
      for x := 0 ; x <= 19; x++ {
        for y := 0 ; y <= 19; y++ {
            max_ = max2(max_, find(4, m, x, y, dx, dy));
          }
      }
  }
  fmt.Printf("%d\n", max_);
}

