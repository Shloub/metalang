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


func foo() {
  var a int = 0
  /* test */
  a ++;
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
  var out_ int = 0
  /* On déclare un entier qui contiendra la somme */
  for i := 1 ; i <= n; i++ {
    /* La boucle : i est le diviseur potentiel*/
      if (n % i) == 0 {
        /* Si i divise */
          out_ += i;
          /* On incrémente */
      } else {
        /* nop */
      }
  }
  return out_
  /*On renvoie out*/
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  /* Programme principal */
  var n int = 0
  fmt.Fscanf(reader, "%d", &n);
  /* Lecture de l'entier */
  var b int = sumdiv(n)
  fmt.Printf("%d", b);
}

