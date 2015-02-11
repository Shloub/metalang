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

func min2_(a int, b int) int{
  if a < b {
    return a
  } else {
    return b
  }
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
    var out0 int = 1 + min2_(min2_(min2_(val1, val2), val3), val4)
    cache[posY][posX] = out0;
    return out0
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
  var x int
  fmt.Fscanf(reader, "%d", &x)
  skip()
  var y int
  fmt.Fscanf(reader, "%d", &y)
  skip()
  fmt.Printf("%d %d\n", x, y);
  var e [][]byte = make([][]byte, y)
  for f := 0 ; f <= y - 1; f++ {
    var g []byte = make([]byte, x)
      for h := 0 ; h <= x - 1; h++ {
        fmt.Fscanf(reader, "%c", &g[h])
      }
      skip()
      e[f] = g;
  }
  var tab [][]byte = e
  var result int = pathfind(tab, x, y)
  fmt.Printf("%d", result);
}

