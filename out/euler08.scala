object euler08
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

  def max2_(a : Int, b : Int): Int = {
    if (a > b)
      return a;
    else
      return b;
  }
  
  
  def main(args : Array[String])
  {
    var i: Int = 1;
    var last :Array[Int] = new Array[Int](5);
    for (j <- 0 to 5 - 1)
    {
      var c = read_char()
      var d: Int = (c).toInt - ('0').toInt;
      i = i * d;
      last(j) = d;
    }
    var max0: Int = i;
    var index: Int = 0;
    var nskipdiv: Int = 0;
    for (k <- 1 to 995)
    {
      var e = read_char()
      var f: Int = (e).toInt - ('0').toInt;
      if (f == 0)
      {
        i = 1;
        nskipdiv = 4;
      }
      else
      {
        i = i * f;
        if (nskipdiv < 0)
          i = i / last(index);
        nskipdiv = nskipdiv - 1;
      }
      last(index) = f;
      index = (index + 1) % 5;
      max0 = max2_(max0, i);
    }
    printf("%d\n", max0);
  }
  
}

