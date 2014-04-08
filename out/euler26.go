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


func periode(restes []int, len int, a int, b int) int{
  for a != 0{
              var chiffre int = a / b
              _ = chiffre
              var reste int = a % b
              for i := 0 ; i <= len - 1; i++ {
                if restes[i] == reste {
                    return len - i
                  }
              }
              restes[len] = reste;
              len ++;
              a = reste * 10;
  }
  return 0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var c int = 1000
  var t []int = make([]int, c)
  for j := 0 ; j <= c - 1; j++ {
    t[j] = 0;
  }
  var m int = 0
  var mi int = 0
  for i := 1 ; i <= 1000; i++ {
    var p int = periode(t, 0, 1, i)
      if p > m {
        mi = i;
          m = p;
      }
  }
  fmt.Printf("%d\n%d\n", mi, m);
}

