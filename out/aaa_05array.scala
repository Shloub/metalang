object aaa_05array
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

  def id(b : Array[Boolean]): Array[Boolean] = {
    return b;
  }
  
  def g(t : Array[Boolean], index : Int){
    t(index) = false;
  }
  
  
  def main(args : Array[String])
  {
    var j: Int = 0;
    var a :Array[Boolean] = new Array[Boolean](5);
    for (i <- 0 to 5 - 1)
    {
      printf("%d", i);
      j = j + i;
      a(i) = (i % 2) == 0;
    }
    printf("%d ", j);
    var c: Boolean = a(0);
    if (c)
      printf("True");
    else
      printf("False");
    printf("\n");
    g(id(a), 0);
    var d: Boolean = a(0);
    if (d)
      printf("True");
    else
      printf("False");
    printf("\n");
  }
  
}

