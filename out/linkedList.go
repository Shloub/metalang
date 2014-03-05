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



type intlist struct {
  head int;
  tail * intlist;
}

func cons(list * intlist, i int) * intlist{
  var out_ * intlist = new (intlist)
  (*out_).head=i;
  (*out_).tail=list;
  return out_
}

func rev2(empty * intlist, acc * intlist, torev * intlist) * intlist{
  if torev == empty {
    return acc
  } else {
    var acc2 * intlist = new (intlist)
    (*acc2).head=(*torev).head;
    (*acc2).tail=acc;
    return rev2(empty, acc, (*torev).tail)
  }
}

func rev(empty * intlist, torev * intlist) * intlist{
  return rev2(empty, empty, torev)
}

func test(empty * intlist) {
  var list * intlist = empty
  var i int = -1
  for i != 0{
              fmt.Fscanf(reader, "%d", &i);
              if i != 0 {
                list = cons(list, i);
              }
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  
}

