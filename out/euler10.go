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


func eratostene(t []int, max_ int) int{
  var sum int = 0
  for i := 2 ; i <= max_ - 1; i++ {
    if t[i] == i {
        sum += i;
          var j int = i * i
          /*
			detect overflow
			*/
          if j / i == i {
            for j < max_ && j > 0{
                                   t[j] = 0;
                                   j += i;
              }
          }
      }
  }
  return sum
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var n int = 100000
  /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
  var t []int = make([]int, n)
  for i := 0 ; i <= n - 1; i++ {
    t[i] = i;
  }
  t[1] = 0;
  var a int = eratostene(t, n)
  fmt.Printf("%d\n", a);
}

