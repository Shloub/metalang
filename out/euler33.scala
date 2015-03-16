object euler33
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
  
  def min2_(a : Int, b : Int): Int = {
    if (a < b)
      return a;
    else
      return b;
  }
  
  def pgcd(a : Int, b : Int): Int = {
    var c: Int = min2_(a, b);
    var d: Int = max2_(a, b);
    var reste: Int = d % c;
    if (reste == 0)
      return c;
    else
      return pgcd(c, reste);
  }
  
  
  def main(args : Array[String])
  {
    var top: Int = 1;
    var bottom: Int = 1;
    for (i <- 1 to 9)
      for (j <- 1 to 9)
        for (k <- 1 to 9)
          if (i != j && j != k)
        {
          var a: Int = i * 10 + j;
          var b: Int = j * 10 + k;
          if (a * k == i * b)
          {
            printf("%d/%d\n", a, b);
            top = top * a;
            bottom = bottom * b;
          }
        }
    printf("%d/%d\n", top, bottom);
    var p: Int = pgcd(top, bottom);
    printf("pgcd=%d\n%d\n", p, bottom / p);
  }
  
}

