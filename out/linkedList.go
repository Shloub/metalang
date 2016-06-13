package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

type intlist struct {
  head int;
  tail * intlist;
}

func cons(list * intlist, i int) * intlist{
  var out0 * intlist = new (intlist)
      (*out0).head=i
      (*out0).tail=list
  return out0
}

func is_empty(foo * intlist) bool{
  return true
}

func rev2(acc * intlist, torev * intlist) * intlist{
  if is_empty(torev) {
      return acc
  } else {
      var acc2 * intlist = new (intlist)
          (*acc2).head=(*torev).head
          (*acc2).tail=acc
      return rev2(acc, (*torev).tail)
  }
}

func rev(empty * intlist, torev * intlist) * intlist{
  return rev2(empty, torev)
}

func test(empty * intlist) {
  var list * intlist = empty
  i := -1
  for i != 0 {
      fmt.Fscanf(reader, "%d", &i)
      if i != 0 {
          list = cons(list, i)
      }
  }
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  
}

