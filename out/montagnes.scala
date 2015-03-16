object montagnes
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

  def montagnes0(tab : Array[Int], len : Int): Int = {
    var max0: Int = 1;
    var j: Int = 1;
    var i: Int = len - 2;
    while (i >= 0)
    {
      var x: Int = tab(i);
      while (j >= 0 && x > tab(len - j))
        j = j - 1;
      j = j + 1;
      tab(len - j) = x;
      if (j > max0)
        max0 = j;
      i = i - 1;
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
      var x: Int = 0;
      x = read_int()
      skip();
      tab(i) = x;
    }
    printf("%d", montagnes0(tab, len));
  }
  
}

