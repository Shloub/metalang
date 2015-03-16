object dichoexp
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

  def exp0(a : Int, b : Int): Int = {
    if (b == 0)
      return 1;
    if ((b % 2) == 0)
    {
      var o: Int = exp0(a, b / 2);
      return o * o;
    }
    else
      return a * exp0(a, b - 1);
  }
  
  
  def main(args : Array[String])
  {
    var a: Int = 0;
    var b: Int = 0;
    a = read_int()
    skip();
    b = read_int()
    printf("%d", exp0(a, b));
  }
  
}

