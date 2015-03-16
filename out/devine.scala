object devine
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

  def devine0(nombre : Int, tab : Array[Int], len : Int): Boolean = {
    var i: Int=0;
    var min0: Int = tab(0);
    var max0: Int = tab(1);
    for (i <- 2 to len - 1)
    {
      if (tab(i) > max0 || tab(i) < min0)
        return false;
      if (tab(i) < nombre)
        min0 = tab(i);
      if (tab(i) > nombre)
        max0 = tab(i);
      if (tab(i) == nombre && len != i + 1)
        return false;
    }
    return true;
  }
  
  
  def main(args : Array[String])
  {
    var nombre = read_int()
    skip();
    var len = read_int()
    skip();
    var tab :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    {
      var tmp = read_int()
      skip();
      tab(i) = tmp;
    }
    var a: Boolean = devine0(nombre, tab, len);
    if (a)
      printf("True");
    else
      printf("False");
  }
  
}

