object euler07
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
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def divisible(n : Int, t : Array[Int], size : Int): Boolean = {
    var i: Int=0;
    for (i <- 0 to size - 1)
      if ((n % t(i)) == 0)
      return true;
    return false;
  }
  
  def find(_n : Int, t : Array[Int], _used : Int, nth : Int): Int = {
    var n = _n;
    var used = _used;
    while (used != nth)
      if (divisible(n, t, used))
      n = n + 1;
    else
    {
      t(used) = n;
      n = n + 1;
      used = used + 1;
    }
    return t(used - 1);
  }
  
  
  def main(args : Array[String])
  {
    var n: Int = 10001;
    var t :Array[Int] = new Array[Int](n);
    for (i <- 0 to n - 1)
      t(i) = 2;
    printf("%d\n", find(3, t, 1, n));
  }
  
}

