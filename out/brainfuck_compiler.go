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

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
func main() {
  reader = bufio.NewReader(os.Stdin)
  var input byte = ' '
  _ = input
  var current_pos int = 500
  var mem []int = make([]int, 1000)
  for i := 0 ; i <= 1000 - 1; i++ {
    mem[i] = 0;
  }
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  current_pos ++;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  mem[current_pos] = mem[current_pos] + 1;
  for mem[current_pos] != 0{
                             mem[current_pos] = mem[current_pos] - 1;
                             current_pos --;
                             mem[current_pos] = mem[current_pos] + 1;
                             fmt.Printf("%c", (byte)(mem[current_pos]));
                             current_pos ++;
  }
}

