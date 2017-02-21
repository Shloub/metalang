object fibo
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
La suite de fibonaci
*/
  def fibo0(a : Int, b : Int, i : Int): Int = {
    var out0: Int = 0;
    var a2: Int = a;
    var b2: Int = b;
    for (j <- 0 to i + 1)
    {
        out0 = out0 + a2;
        var tmp: Int = b2;
        b2 = b2 + a2;
        a2 = tmp;
    }
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var a: Int = 0;
    var b: Int = 0;
    var i: Int = 0;
    a = read_int();
    skip();
    b = read_int();
    skip();
    i = read_int();
    printf("%d", fibo0(a, b, i));
  }
  
}

