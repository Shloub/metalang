object rot13
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
  
  /*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
  
  def main(args : Array[String])
  {
    var strlen = read_int();
    skip();
    var tab4 :Array[Char] = new Array[Char](strlen);
    for (toto <- 0 to strlen - 1)
    {
        var tmpc = read_char();
        var c: Int = (tmpc).toInt;
        if (tmpc != ' ')
            c = (c - ('a').toInt + 13) % 26 + ('a').toInt;
        tab4(toto) = (c).toChar;
    }
    for (j <- 0 to strlen - 1)
        printf("%c", tab4(j));
  }
  
}

