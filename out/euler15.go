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


func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int = 10
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n ++;
  var tab [][]int = make([][]int, n)
  for i := 0 ; i <= n - 1; i++ {
    var tab2 []int = make([]int, n)
      for j := 0 ; j <= n - 1; j++ {
        tab2[j] = 0;
      }
      tab[i] = tab2;
  }
  for l := 0 ; l <= n - 1; l++ {
    tab[n - 1][l] = 1;
      tab[l][n - 1] = 1;
  }
  for o := 2 ; o <= n; o++ {
    var r int = n - o
      for p := 2 ; p <= n; p++ {
        var q int = n - p
          tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
      }
  }
  for m := 0 ; m <= n - 1; m++ {
    for k := 0 ; k <= n - 1; k++ {
        var a int = tab[m][k]
          fmt.Printf("%d ", a);
      }
      fmt.Printf("\n");
  }
  var b int = tab[0][0]
  fmt.Printf("%d\n", b);
}

