object euler34
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
    var f :Array[Int] = new Array[Int](10);
    for (j <- 0 to 10 - 1)
      f(j) = 1;
    for (i <- 1 to 9)
    {
      f(i) = f(i) * i * f(i - 1);
      printf("%d ", f(i));
    }
    var out0: Int = 0;
    printf("\n");
    for (a <- 0 to 9)
      for (b <- 0 to 9)
        for (c <- 0 to 9)
          for (d <- 0 to 9)
            for (e <- 0 to 9)
              for (g <- 0 to 9)
              {
                var sum: Int = f(a) + f(b) + f(c) + f(d) + f(e) + f(g);
                var num: Int = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                if (a == 0)
                {
                  sum = sum - 1;
                  if (b == 0)
                  {
                    sum = sum - 1;
                    if (c == 0)
                    {
                      sum = sum - 1;
                      if (d == 0)
                        sum = sum - 1;
                    }
                  }
                }
                if (sum == num && sum != 1 && sum != 2)
                {
                  out0 = out0 + num;
                  printf("%d ", num);
                }
              }
    printf("\n%d\n", out0);
  }
  
}

