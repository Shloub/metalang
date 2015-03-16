object euler24
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

  def fact(n : Int): Int = {
    var i: Int=0;
    var prod: Int = 1;
    for (i <- 2 to n)
      prod = prod * i;
    return prod;
  }
  
  def show(lim : Int, _nth : Int){
    var nth = _nth;
    var m: Int=0;
    var k: Int=0;
    var l: Int=0;
    var j: Int=0;
    var i: Int=0;
    var t :Array[Int] = new Array[Int](lim);
    for (i <- 0 to lim - 1)
      t(i) = i;
    var pris :Array[Boolean] = new Array[Boolean](lim);
    for (j <- 0 to lim - 1)
      pris(j) = false;
    for (k <- 1 to lim - 1)
    {
      var n: Int = fact(lim - k);
      var nchiffre: Int = nth / n;
      nth = nth % n;
      for (l <- 0 to lim - 1)
        if (!pris(l))
      {
        if (nchiffre == 0)
        {
          printf("%d", l);
          pris(l) = true;
        }
        nchiffre = nchiffre - 1;
      }
    }
    for (m <- 0 to lim - 1)
      if (!pris(m))
      printf("%d", m);
    printf("\n");
  }
  
  
  def main(args : Array[String])
  {
    show(10, 999999);
  }
  
}

