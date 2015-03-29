object euler08
{
  
var buffer = "";
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}

  def max2_0(a : Int, b : Int): Int = {
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
      max0 = max2_0(max0, i);
    }
    printf("%d\n", max0);
  }
  
}

