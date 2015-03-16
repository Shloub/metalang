object pathfindList
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

  def pathfind_aux(cache : Array[Int], tab : Array[Int], len : Int, pos : Int): Int = {
    if (pos >= len - 1)
      return 0;
    else if (cache(pos) != -1)
      return cache(pos);
    else
    {
      cache(pos) = len * 2;
      var posval: Int = pathfind_aux(cache, tab, len, tab(pos));
      var oneval: Int = pathfind_aux(cache, tab, len, pos + 1);
      var out0: Int = 0;
      if (posval < oneval)
        out0 = 1 + posval;
      else
        out0 = 1 + oneval;
      cache(pos) = out0;
      return out0;
    }
  }
  
  def pathfind(tab : Array[Int], len : Int): Int = {
    var i: Int=0;
    var cache :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
      cache(i) = -1;
    return pathfind_aux(cache, tab, len, 0);
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
    var result: Int = pathfind(tab, len);
    printf("%d", result);
  }
  
}

