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


func min2(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
}

func min3(a int, b int, c int) int{
  return min2(min2(a, b), c)
}

func min4(a int, b int, c int, d int) int{
  var f int = min2(a, b)
  var g int = c
  var h int = d
  var e int = min2(min2(f, g), h)
  return e
}

func read_int() int{
  var out_ int = 0
  fmt.Fscanf(reader, "%d", &out_);
  skip()
  return out_
}

func read_char_line(n int) []byte{
  var tab []byte = make([]byte, n)
  for i := 0 ; i <= n - 1; i++ {
    var t byte = '_'
      fmt.Fscanf(reader, "%c", &t);
      tab[i] = t;
  }
  skip()
  return tab
}

func read_char_matrix(x int, y int) [][]byte{
  var tab [][]byte = make([][]byte, y)
  for z := 0 ; z <= y - 1; z++ {
    var l int = x
      var m []byte = make([]byte, l)
      for o := 0 ; o <= l - 1; o++ {
        var p byte = '_'
          fmt.Fscanf(reader, "%c", &p);
          m[o] = p;
      }
      skip()
      var k []byte = m
      tab[z] = k;
  }
  return tab
}

func pathfind_aux(cache [][]int, tab [][]byte, x int, y int, posX int, posY int) int{
  if posX == x - 1 && posY == y - 1 {
    return 0
  } else if posX < 0 || posY < 0 || posX >= x || posY >= y {
    return x * y * 10
  } else if tab[posY][posX] == '#' {
    return x * y * 10
  } else if cache[posY][posX] != -1 {
    return cache[posY][posX]
  } else {
    cache[posY][posX] = x * y * 10;
    var val1 int = pathfind_aux(cache, tab, x, y, posX + 1, posY)
    var val2 int = pathfind_aux(cache, tab, x, y, posX - 1, posY)
    var val3 int = pathfind_aux(cache, tab, x, y, posX, posY - 1)
    var val4 int = pathfind_aux(cache, tab, x, y, posX, posY + 1)
    var r int = val1
    var s int = val2
    var u int = val3
    var v int = val4
    var w int = min2(r, s)
    var ba int = u
    var bb int = v
    var bc int = min2(min2(w, ba), bb)
    var q int = bc
    var out_ int = 1 + q
    cache[posY][posX] = out_;
    return out_
  }   
}

func pathfind(tab [][]byte, x int, y int) int{
  var cache [][]int = make([][]int, y)
  for i := 0 ; i <= y - 1; i++ {
    var tmp []int = make([]int, x)
      for j := 0 ; j <= x - 1; j++ {
        fmt.Printf("%c", tab[i][j]);
          tmp[j] = -1;
      }
      fmt.Printf("\n");
      cache[i] = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var be int = 0
  fmt.Fscanf(reader, "%d", &be);
  skip()
  var bd int = be
  var x int = bd
  var bg int = 0
  fmt.Fscanf(reader, "%d", &bg);
  skip()
  var bf int = bg
  var y int = bf
  fmt.Printf("%d %d\n", x, y);
  var tab [][]byte = read_char_matrix(x, y)
  var result int = pathfind(tab, x, y)
  fmt.Printf("%d", result);
}

