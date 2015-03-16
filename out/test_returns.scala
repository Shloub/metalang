object test_returns
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

  def is_pair(i : Int): Boolean = {
    var j: Int = 1;
    if (i < 10)
    {
      j = 2;
      if (i == 0)
      {
        j = 4;
        return true;
      }
      j = 3;
      if (i == 2)
      {
        j = 4;
        return true;
      }
      j = 5;
    }
    j = 6;
    if (i < 20)
    {
      if (i == 22)
        j = 0;
      j = 8;
    }
    return (i % 2) == 0;
  }
  
  
  def main(args : Array[String])
  {
    
  }
  
}

