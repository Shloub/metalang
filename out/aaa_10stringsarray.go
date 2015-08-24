package main
import "fmt"

type toto struct {
  s string;
  v int;
}

func idstring(s string) string{
  return s
}

func printstring(s string) {
  fmt.Printf("%s\n", idstring(s));
}

func print_toto(t * toto) {
  fmt.Printf("%s = %d\n", (*t).s, (*t).v);
}

func main() {
  var tab []string = make([]string, 2)
  for i := 0 ; i < 2; i++ {
    tab[i] = idstring("chaine de test");
  }
  for j := 0 ; j <= 1; j++ {
    printstring(idstring(tab[j]));
  }
  var a * toto = new (toto)
  (*a).s="one"
  (*a).v=1
  print_toto(a);
}

