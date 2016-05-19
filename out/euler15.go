package main
import "fmt"
func main() {
  var n int = 10
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n++;
  var tab [][]int = make([][]int, n)
  for i := 0 ; i < n; i++ {
    var tab2 []int = make([]int, n)
      for j := 0 ; j < n; j++ {
        tab2[j] = 0;
      }
      tab[i] = tab2;
  }
  for l := 0 ; l < n; l++ {
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
  for m := 0 ; m < n; m++ {
    for k := 0 ; k < n; k++ {
        fmt.Printf("%d ", tab[m][k]);
      }
      fmt.Printf("\n");
  }
  fmt.Printf("%d\n", tab[0][0]);
}

