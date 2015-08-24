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
/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/
func find0(len int, tab [][]int, cache [][]int, x int, y int) int{
  /*
	Cette fonction est récursive
	*/
  if y == len - 1 {
    return tab[y][x]
  } else if x > y {
    return -10000
  } else if cache[y][x] != 0 {
    return cache[y][x]
  }  
  var result int = 0
  var out0 int = find0(len, tab, cache, x, y + 1)
  var out1 int = find0(len, tab, cache, x + 1, y + 1)
  if out0 > out1 {
    result = out0 + tab[y][x];
  } else {
    result = out1 + tab[y][x];
  }
  cache[y][x] = result;
  return result
}

func find(len int, tab [][]int) int{
  var tab2 [][]int = make([][]int, len)
  for i := 0 ; i < len; i++ {
    var tab3 []int = make([]int, i + 1)
      for j := 0 ; j < i + 1; j++ {
        tab3[j] = 0;
      }
      tab2[i] = tab3;
  }
  return find0(len, tab, tab2, 0, 0)
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab [][]int = make([][]int, len)
  for i := 0 ; i < len; i++ {
    var tab2 []int = make([]int, i + 1)
      for j := 0 ; j < i + 1; j++ {
        var tmp int = 0
          fmt.Fscanf(reader, "%d", &tmp)
          skip()
          tab2[j] = tmp;
      }
      tab[i] = tab2;
  }
  fmt.Printf("%d\n", find(len, tab));
  for k := 0 ; k < len; k++ {
    for l := 0 ; l <= k; l++ {
        fmt.Printf("%d ", tab[k][l]);
      }
      fmt.Printf("\n");
  }
}

