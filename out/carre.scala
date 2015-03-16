object carre
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

  def min2_(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  
  def main(args : Array[String])
  {
    var x = read_int()
    skip();
    var y = read_int()
    skip();
    var tab :Array[Array[Int]] = new Array[Array[Int]](y);
    for (d <- 0 to y - 1)
    {
      var e :Array[Int] = new Array[Int](x);
      for (f <- 0 to x - 1)
      {
        e(f) = read_int()
        skip();
      }
      tab(d) = e;
    }
    for (ix <- 1 to x - 1)
      for (iy <- 1 to y - 1)
        if (tab(iy)(ix) == 1)
        tab(iy)(ix) = min2_(min2_(tab(iy)(ix - 1), tab(iy - 1)(ix)), tab(iy - 1)(ix - 1)) + 1;
    for (jy <- 0 to y - 1)
    {
      for (jx <- 0 to x - 1)
      {
        printf("%d ", tab(jy)(jx));
      }
      printf("\n");
    }
  }
  
}

