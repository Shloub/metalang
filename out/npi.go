package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
func is_number(c byte) bool{
  return (int)(c) <= (int)('9') && (int)(c) >= (int)('0')
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
func npi0(str []byte, len int) int{
  var stack []int = make([]int, len)
  for i := 0 ; i < len; i++ {
    stack[i] = 0;
  }
  var ptrStack int = 0
  var ptrStr int = 0
  for ptrStr < len{
    if str[ptrStr] == ' ' {
      ptrStr ++;
    } else if is_number(str[ptrStr]) {
      var num int = 0
        for str[ptrStr] != ' '{
          num = num * 10 + (int)(str[ptrStr]) - (int)('0');
          ptrStr ++;
        }
        stack[ptrStack] = num;
        ptrStack ++;
    } else if str[ptrStr] == '+' {
      stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
        ptrStack --;
        ptrStr ++;
    }  
  }
  return stack[0]
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tab []byte = make([]byte, len)
  for i := 0 ; i < len; i++ {
    var tmp byte = '\x00'
      fmt.Fscanf(reader, "%c", &tmp)
      tab[i] = tmp;
  }
  var result int = npi0(tab, len)
  fmt.Printf("%d", result);
}

