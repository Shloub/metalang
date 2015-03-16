object euler10
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

  def eratostene(t : Array[Int], max0 : Int): Int = {
    var i: Int=0;
    var sum: Int = 0;
    for (i <- 2 to max0 - 1)
      if (t(i) == i)
    {
      sum = sum + i;
      if (max0 / i > i)
      {
        var j: Int = i * i;
        while (j < max0 && j > 0)
        {
          t(j) = 0;
          j = j + i;
        }
      }
    }
    return sum;
  }
  
  
  def main(args : Array[String])
  {
    var n: Int = 100000;
    /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
    var t :Array[Int] = new Array[Int](n);
    for (i <- 0 to n - 1)
      t(i) = i;
    t(1) = 0;
    printf("%d\n", eratostene(t, n));
  }
  
}

