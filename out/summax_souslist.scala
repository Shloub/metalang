object summax_souslist
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

  def summax(lst : Array[Int], len : Int): Int = {
    var i: Int=0;
    var current: Int = 0;
    var max0: Int = 0;
    for (i <- 0 to len - 1)
    {
      current = current + lst(i);
      if (current < 0)
        current = 0;
      if (max0 < current)
        max0 = current;
    }
    return max0;
  }
  
  
  def main(args : Array[String])
  {
    var len: Int = 0;
    len = read_int()
    skip();
    var tab :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    {
      var tmp: Int = 0;
      tmp = read_int()
      skip();
      tab(i) = tmp;
    }
    var result: Int = summax(tab, len);
    printf("%d", result);
  }
  
}

