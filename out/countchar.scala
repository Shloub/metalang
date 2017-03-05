object countchar
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
  
  def nth(tab : Array[Char], tofind : Char, len : Int): Int = {
    var out0: Int = 0;
    for (i <- 0 to len - 1)
        if (tab(i) == tofind)
            out0 = out0 + 1;
    return out0;
  }
  
  def main(args : Array[String])
  {
    var len: Int = 0;
    len = read_int();
    skip();
    var tofind: Char = '\u0000';
    tofind = read_char();
    skip();
    var tab :Array[Char] = new Array[Char](len);
    for (i <- 0 to len - 1)
    {
        var tmp: Char = '\u0000';
        tmp = read_char();
        tab(i) = tmp;
    }
    var result: Int = nth(tab, tofind, len);
    printf("%d", result);
  }
  
}

