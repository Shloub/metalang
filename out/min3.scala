object min3
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

  def min2_(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  
  def main(args : Array[String])
  {
    printf("%d %d %d %d %d %d\n", min2_(min2_(2, 3), 4), min2_(min2_(2, 4), 3), min2_(min2_(3, 2), 4), min2_(min2_(3, 4), 2), min2_(min2_(4, 2), 3), min2_(min2_(4, 3), 2));
  }
  
}

