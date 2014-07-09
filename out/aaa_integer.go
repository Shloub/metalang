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
  var i int = 0
  i --;
  fmt.Printf("%d\n", i);
  i += 55;
  fmt.Printf("%d\n", i);
  i *= 13;
  fmt.Printf("%d\n", i);
  i /= 2;
  fmt.Printf("%d\n", i);
  i ++;
  fmt.Printf("%d\n", i);
  i /= 3;
  fmt.Printf("%d\n", i);
  i --;
  fmt.Printf("%d\n", i);
  /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
  fmt.Printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", 117 / 17, 117 / -17, -117 / 17, -117 / -17, 117 % 17, 117 % -17, -117 % 17, -117 % -17);
}

