object euler03
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
    var maximum: Int = 1;
    var b0: Int = 2;
    var a: Int = 408464633;
    var sqrtia: Int = math.sqrt(a).toInt;
    while (a != 1)
    {
      var b: Int = b0;
      var found: Boolean = false;
      while (b <= sqrtia)
      {
        if ((a % b) == 0)
        {
          a = a / b;
          b0 = b;
          b = a;
          sqrtia = math.sqrt(a).toInt;
          found = true;
        }
        b = b + 1;
      }
      if (!found)
      {
        printf("%d\n", a);
        a = 1;
      }
    }
  }
  
}

