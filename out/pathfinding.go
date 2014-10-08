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
    var n int = min2_(val1, val2)
    var o int = min2_(n, val3)
    var p int = min2_(o, val4)
    var q int = p
    var m int = q
    var out0 int = 1 + m
    cache[posY][posX] = out0;
    return out0
  }   
}

func pathfind(tab [][]byte, x int, y int) int{
  var cache [][]int = make([][]int, y)
  for i := 0 ; i <= y - 1; i++ {
    var tmp []int = make([]int, x)
      for j := 0 ; j <= x - 1; j++ {
        tmp[j] = -1;
      }
      cache[i] = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var x int = 0
  var y int = 0
  fmt.Fscanf(reader, "%d", &x)
  skip()
  fmt.Fscanf(reader, "%d", &y)
  skip()
  var tab [][]byte = make([][]byte, y)
  for i := 0 ; i <= y - 1; i++ {
    var tab2 []byte = make([]byte, x)
      for j := 0 ; j <= x - 1; j++ {
        var tmp byte = '\000'
          fmt.Fscanf(reader, "%c", &tmp)
          tab2[j] = tmp;
      }
      skip()
      tab[i] = tab2;
  }
  var result int = pathfind(tab, x, y)
  fmt.Printf("%d", result);
}

