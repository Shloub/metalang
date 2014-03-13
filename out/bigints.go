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


func max2(a int, b int) int{
  if a > b {
    return a
  }
  return b
}


type bigint struct {
  sign bool;
  chiffres_len int;
  chiffres []int;
}

func read_big_int() * bigint{
  fmt.Printf("read_big_int");
  var len int = 0
  fmt.Fscanf(reader, "%d", &len);
  skip()
  fmt.Printf("%d=len ", len);
  var sign byte = '_'
  fmt.Fscanf(reader, "%c", &sign);
  fmt.Printf("%c=sign\n", sign);
  var chiffres []int = make([]int, len)
  for d := 0 ; d <= len - 1; d++ {
    var c byte = '_'
      fmt.Fscanf(reader, "%c", &c);
      fmt.Printf("%c=c\n", c);
      chiffres[d] = (int)(c) - (int)('0');
  }
  for i := 0 ; i <= len / 2; i++ {
    var tmp int = chiffres[i]
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
  }
  skip()
  var out_ * bigint = new (bigint)
  (*out_).sign=sign == '+';
  (*out_).chiffres_len=len;
  (*out_).chiffres=chiffres;
  return out_
}

func print_big_int(a * bigint) {
  if (*a).sign {
    fmt.Printf("+");
  } else {
    fmt.Printf("-");
  }
  for i := 0 ; i <= (*a).chiffres_len - 1; i++ {
    var e int = (*a).chiffres[i]
      fmt.Printf("%d", e);
  }
}

func neg_big_int(a * bigint) * bigint{
  var out_ * bigint = new (bigint)
  (*out_).sign=!(*a).sign;
  (*out_).chiffres_len=(*a).chiffres_len;
  (*out_).chiffres=(*a).chiffres;
  return out_
}

func add_big_int(a * bigint, b * bigint) * bigint{
  var len int = max2((*a).chiffres_len, (*b).chiffres_len) + 1
  var retenue int = 0
  var sign bool = true
  var chiffres []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    var tmp int = retenue
      if i < (*a).chiffres_len {
        tmp += (*a).chiffres[i];
      }
      if i < (*b).chiffres_len {
        tmp += (*b).chiffres[i];
      }
      retenue = tmp / 10;
      chiffres[i] = tmp % 10;
  }
  var out_ * bigint = new (bigint)
  (*out_).sign=sign;
  (*out_).chiffres_len=len;
  (*out_).chiffres=chiffres;
  return out_
}

/*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/
func main() {
  reader = bufio.NewReader(os.Stdin)
  var a * bigint = read_big_int()
  var b * bigint = read_big_int()
  print_big_int(add_big_int(a, b));
}

