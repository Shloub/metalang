object aaa_read1
{
  
var buffer = "";
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
    var str :Array[Char] = new Array[Char](12);
    for (a <- 0 to 12 - 1)
      str(a) = read_char()
    skip();
    for (i <- 0 to 11)
      printf("%c", str(i));
  }
  
}

