object euler30
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

  
  def main(args : Array[String])
  {
    /*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
    var p :Array[Int] = new Array[Int](10);
    for (i <- 0 to 10 - 1)
      p(i) = i * i * i * i * i;
    var sum: Int = 0;
    for (a <- 0 to 9)
      for (b <- 0 to 9)
        for (c <- 0 to 9)
          for (d <- 0 to 9)
            for (e <- 0 to 9)
              for (f <- 0 to 9)
              {
                var s: Int = p(a) + p(b) + p(c) + p(d) + p(e) + p(f);
                var r: Int = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000;
                if (s == r && r != 1)
                {
                  printf("%d%d%d%d%d%d %d\n", f, e, d, c, b, a, r);
                  sum = sum + r;
                }
              }
    printf("%d", sum);
  }
  
}

