package main
import "fmt"
/*
TODO ajouter un record qui contient des chaines.
*/
func idstring(s string) string{
  return s
}

func printstring(s string) {
  fmt.Printf("%s\n", idstring(s));
}

func main() {
  var tab []string = make([]string, 2)
  for i := 0 ; i <= 2 - 1; i++ {
    tab[i] = idstring("chaine de test");
  }
  for j := 0 ; j <= 1; j++ {
    printstring(idstring(tab[j]));
  }
}

