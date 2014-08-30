package main
import "fmt"
import "math"
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

func is_triangular(n int) bool{
  /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
  var a int = int(math.Sqrt(float64(n * 2)))
  return a * (a + 1) == n * 2
}

func score() int{
  skip()
  var len int
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var sum int = 0
  for i := 1 ; i <= len; i++ {
    var c byte
    fmt.Fscanf(reader, "%c", &c)
      sum += ((int)(c) - (int)('A')) + 1;
      /*		print c print " " print sum print " " */
  }
  if is_triangular(sum) {
    return 1
  } else {
    return 0
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  for i := 1 ; i <= 55; i++ {
    if is_triangular(i) {
        fmt.Printf("%d ", i);
      }
  }
  fmt.Printf("\n");
  var sum int = 0
  var n int
  fmt.Fscanf(reader, "%d", &n)
  for i := 1 ; i <= n; i++ {
    sum += score();
  }
  fmt.Printf("%d\n", sum);
}

