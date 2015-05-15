object linkedList
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}

  class Intlist(_head: Int, _tail: Intlist){
    var head: Int=_head;
    var tail: Intlist=_tail;
  }
  
  def cons(list : Intlist, i : Int): Intlist = {
    var out0: Intlist = new Intlist(i, list);
    return out0;
  }
  
  def is_empty(foo : Intlist): Boolean = {
    return true;
  }
  
  def rev2(acc : Intlist, torev : Intlist): Intlist = {
    if (is_empty(torev))
      return acc;
    else
    {
      var acc2: Intlist = new Intlist(torev.head, acc);
      return rev2(acc, torev.tail);
    }
  }
  
  def rev(empty : Intlist, torev : Intlist): Intlist = {
    return rev2(empty, torev);
  }
  
  def test(empty : Intlist){
    var list: Intlist = empty;
    var i: Int = -1;
    while (i != 0)
    {
      i = read_int()
      if (i != 0)
        list = cons(list, i);
    }
  }
  
  
  def main(args : Array[String])
  {
    
  }
  
}

