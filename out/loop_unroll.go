package main
import "fmt"
/*
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
*/
func main() {
  var j int = 0
  j = 0;
  fmt.Printf("%d\n", j);
  j = 1;
  fmt.Printf("%d\n", j);
  j = 2;
  fmt.Printf("%d\n", j);
  j = 3;
  fmt.Printf("%d\n", j);
  j = 4;
  fmt.Printf("%d\n", j);
}

