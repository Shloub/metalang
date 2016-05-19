object euler22
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

  def score(): Int = {
    var i: Int=0;
    skip();
    var len = read_int()
    skip();
    var sum: Int = 0;
    for (i <- 1 to len)
    {
        var c = read_char()
        sum = sum + (c).toInt - ('A').toInt + 1;
        /*		print c print " " print sum print " " */
    }
    return sum;
  }
  
  
  def main(args : Array[String])
  {
    var sum: Int = 0;
    var n = read_int()
    for (i <- 1 to n)
      sum = sum + i * score();
    printf("%d\n", sum);
  }
  
}

