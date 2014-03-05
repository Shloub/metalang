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
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/

type toto struct {
  foo int;
  bar int;
  blah int;
}

func mktoto(v1 int) * toto{
  var t * toto = new (toto)
  (*t).foo=v1;
  (*t).bar=v1;
  (*t).blah=v1;
  return t
}

func result(t_ * toto, t2_ * toto) int{
  var t * toto = t_
  var t2 * toto = t2_
  var t3 * toto = new (toto)
  (*t3).foo=0;
  (*t3).bar=0;
  (*t3).blah=0;
  t3 = t2;
  t = t2;
  t2 = t3;
  (*t).blah ++;
  var len int = 1
  var cache0 []int = make([]int, len)
  for i := 0 ; i <= len - 1; i++ {
    cache0[i] = -i;
  }
  var cache1 []int = make([]int, len)
  for j := 0 ; j <= len - 1; j++ {
    cache1[j] = j;
  }
  var cache2 []int = cache0
  _ = cache2
  cache0 = cache1;
  cache2 = cache0;
  return (*t).foo + (*t).blah * (*t).bar + (*t).bar * (*t).foo
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var t * toto = mktoto(4)
  var t2 * toto = mktoto(5)
  fmt.Fscanf(reader, "%d", &(*t).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*t).blah);
  skip()
  fmt.Fscanf(reader, "%d", &(*t2).bar);
  skip()
  fmt.Fscanf(reader, "%d", &(*t).blah);
  var a int = result(t, t2)
  fmt.Printf("%d", a);
  var b int = (*t).blah
  fmt.Printf("%d", b);
}

