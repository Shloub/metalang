object euler09
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

  
  def main(args : Array[String])
  {
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (a <- 1 to 1000)
      for (b <- a + 1 to 1000)
      {
        var c: Int = 1000 - a - b;
        var a2b2: Int = a * a + b * b;
        var cc: Int = c * c;
        if (cc == a2b2 && c > a)
        {
          printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c);
        }
      }
  }
  
}

