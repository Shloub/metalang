object aaa_missing
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

  /*
  Ce test a été généré par Metalang.
*/
  def result(len : Int, tab : Array[Int]): Int = {
    var i2: Int=0;
    var i1: Int=0;
    var i: Int=0;
    var tab2 :Array[Boolean] = new Array[Boolean](len);
    for (i <- 0 to len - 1)
      tab2(i) = false;
    for (i1 <- 0 to len - 1)
    {
      printf("%d ", tab(i1));
      tab2(tab(i1)) = true;
    }
    printf("\n");
    for (i2 <- 0 to len - 1)
      if (!tab2(i2))
      return i2;
    return -1;
  }
  
  
  def main(args : Array[String])
  {
    var len = read_int()
    skip();
    printf("%d\n", len);
    var tab :Array[Int] = new Array[Int](len);
    for (a <- 0 to len - 1)
    {
      tab(a) = read_int()
      skip();
    }
    printf("%d\n", result(len, tab));
  }
  
}

