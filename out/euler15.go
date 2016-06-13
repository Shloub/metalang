package main
import "fmt"
func main() {
  n := 10
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n += 1
  var tab [][]int = make([][]int, n)
  for i := 0; i < n; i += 1 {
      var tab2 []int = make([]int, n)
      for j := 0; j < n; j += 1 {
          tab2[j] = 0
      }
      tab[i] = tab2
  }
  for l := 0; l < n; l += 1 {
      tab[n - 1][l] = 1
      tab[l][n - 1] = 1
  }
  for o := 2; o <= n; o += 1 {
      r := n - o
      for p := 2; p <= n; p += 1 {
          q := n - p
          tab[r][q] = tab[r + 1][q] + tab[r][q + 1]
      }
  }
  for m := 0; m < n; m += 1 {
      for k := 0; k < n; k += 1 {
          fmt.Printf("%d ", tab[m][k])
      }
      fmt.Printf("\n")
  }
  fmt.Printf("%d\n", tab[0][0])
}

