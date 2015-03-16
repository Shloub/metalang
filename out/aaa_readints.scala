object aaa_readints
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
    var len = read_int()
    skip();
    printf("%d=len\n", len);
    var tab1 :Array[Int] = new Array[Int](len);
    for (a <- 0 to len - 1)
    {
      tab1(a) = read_int()
      skip();
    }
    for (i <- 0 to len - 1)
    {
      printf("%d=>%d\n", i, tab1(i));
    }
    len = read_int()
    skip();
    var tab2 :Array[Array[Int]] = new Array[Array[Int]](len - 1);
    for (b <- 0 to len - 1 - 1)
    {
      var c :Array[Int] = new Array[Int](len);
      for (d <- 0 to len - 1)
      {
        c(d) = read_int()
        skip();
      }
      tab2(b) = c;
    }
    for (i <- 0 to len - 2)
    {
      for (j <- 0 to len - 1)
      {
        printf("%d ", tab2(i)(j));
      }
      printf("\n");
    }
  }
  
}

