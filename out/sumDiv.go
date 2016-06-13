package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader
func foo() {
  a := 0
  _ = a
  /* test */
  a += 1
  /* test 2 */
}

func foo2() {
  
}

func foo3() {
  if 1 == 1 {
      
  }
}

func sumdiv(n int) int{
  /* On désire renvoyer la somme des diviseurs */
  out0 := 0
  /* On déclare un entier qui contiendra la somme */
  for i := 1; i <= n; i += 1 {
      /* La boucle : i est le diviseur potentiel*/
      if n % i == 0 {
          /* Si i divise */
          out0 += i
          /* On incrémente */
      } else {
          /* nop */
      }
  }
  return out0
  /*On renvoie out*/
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  /* Programme principal */
  n := 0
  fmt.Fscanf(reader, "%d", &n)
  /* Lecture de l'entier */
  fmt.Printf("%d", sumdiv(n))
}

