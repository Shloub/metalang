object euler14
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

  def next0(n : Int): Int = {
    if ((n % 2) == 0)
      return n / 2;
    else
      return 3 * n + 1;
  }
  
  def find(n : Int, m : Array[Int]): Int = {
    if (n == 1)
      return 1;
    else if (n >= 1000000)
      return 1 + find(next0(n), m);
    else if (m(n) != 0)
      return m(n);
    else
    {
      m(n) = 1 + find(next0(n), m);
      return m(n);
    }
  }
  
  
  def main(args : Array[String])
  {
    var m :Array[Int] = new Array[Int](1000000);
    for (j <- 0 to 1000000 - 1)
      m(j) = 0;
    var max0: Int = 0;
    var maxi: Int = 0;
    for (i <- 1 to 999)
    {
      /* normalement on met 999999 mais ça dépasse les int32... */
      var n2: Int = find(i, m);
      if (n2 > max0)
      {
        max0 = n2;
        maxi = i;
      }
    }
    printf("%d\n%d\n", max0, maxi);
  }
  
}

