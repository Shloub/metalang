object aaa_03binding
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

  def g(i : Int): Int = {
    var j: Int = i * 4;
    if ((j % 2) == 1)
      return 0;
    return j;
  }
  
  def h(i : Int){
    printf("%d\n", i);
  }
  
  
  def main(args : Array[String])
  {
    h(14);
    var a: Int = 4;
    var b: Int = 5;
    printf("%d", a + b);
    /* main */
    h(15);
    a = 2;
    b = 1;
    printf("%d", a + b);
  }
  
}

