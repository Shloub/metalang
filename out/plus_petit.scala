object plus_petit
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
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}
  
  def go0(tab : Array[Int], a : Int, b : Int): Int = {
    var m: Int = (a + b) / 2;
    if (a == m)
        if (tab(a) == m)
            return b;
        else
            return a;
    var i: Int = a;
    var j: Int = b;
    while (i < j)
    {
        var e: Int = tab(i);
        if (e < m)
            i = i + 1;
        else
        {
            j = j - 1;
            tab(i) = tab(j);
            tab(j) = e;
        }
    }
    if (i < m)
        return go0(tab, a, m);
    else
        return go0(tab, m, b);
  }
  
  def plus_petit0(tab : Array[Int], len : Int): Int = {
    return go0(tab, 0, len);
  }
  
  
  def main(args : Array[String])
  {
    var len: Int = 0;
    len = read_int();
    skip();
    var tab :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    
    {
        var tmp: Int = 0;
        tmp = read_int();
        skip();
        tab(i) = tmp;
    }
    printf("%d", plus_petit0(tab, len));
  }
  
}

