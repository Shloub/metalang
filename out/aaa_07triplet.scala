object aaa_07triplet
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
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  
  def main(args : Array[String])
  {
    for (i <- 1 to 3)
    {
      var a = read_int()
      skip();
      var b = read_int()
      skip();
      var c = read_int()
      skip();
      printf("a = %d b = %dc =%d\n", a, b, c);
    }
    var l :Array[Int] = new Array[Int](10);
    for (d <- 0 to 10 - 1)
    {
      l(d) = read_int()
      skip();
    }
    for (j <- 0 to 9)
    {
      printf("%d\n", l(j));
    }
  }
  
}

