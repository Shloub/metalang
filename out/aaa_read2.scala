object aaa_read2
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

  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  def main(args : Array[String])
  {
    var len = read_int()
    skip();
    printf("%d=len\n", len);
    var tab :Array[Int] = new Array[Int](len);
    for (a <- 0 to len - 1)
    {
      tab(a) = read_int()
      skip();
    }
    for (i <- 0 to len - 1)
    {
      printf("%d=>%d ", i, tab(i));
    }
    printf("\n");
    var tab2 :Array[Int] = new Array[Int](len);
    for (b <- 0 to len - 1)
    {
      tab2(b) = read_int()
      skip();
    }
    for (i_U <- 0 to len - 1)
    {
      printf("%d==>%d ", i_U, tab2(i_U));
    }
    var strlen = read_int()
    skip();
    printf("%d=strlen\n", strlen);
    var tab4 :Array[Char] = new Array[Char](strlen);
    for (d <- 0 to strlen - 1)
      tab4(d) = read_char()
    skip();
    for (i3 <- 0 to strlen - 1)
    {
      var tmpc: Char = tab4(i3);
      var c: Int = (tmpc).toInt;
      printf("%c:%d ", tmpc, c);
      if (tmpc != ' ')
        c = ((c - ('a').toInt) + 13) % 26 + ('a').toInt;
      tab4(i3) = (c).toChar;
    }
    for (j <- 0 to strlen - 1)
      printf("%c", tab4(j));
  }
  
}

