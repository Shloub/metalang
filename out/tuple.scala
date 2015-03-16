object tuple
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

  class Tuple_int_int(_tuple_int_int_field_0: Int, _tuple_int_int_field_1: Int){
    var tuple_int_int_field_0: Int=_tuple_int_int_field_0;
    var tuple_int_int_field_1: Int=_tuple_int_int_field_1;
  }
  
  def f(tuple0 : Tuple_int_int): Tuple_int_int = {
    var c: Tuple_int_int = tuple0;
    var a: Int = c.tuple_int_int_field_0;
    var b: Int = c.tuple_int_int_field_1;
    var d = new Tuple_int_int(a +
    1, b +
    1);
    return d;
  }
  
  
  def main(args : Array[String])
  {
    var e = new Tuple_int_int(0, 1);
    var t: Tuple_int_int = f(e);
    var g: Tuple_int_int = t;
    var a: Int = g.tuple_int_int_field_0;
    var b: Int = g.tuple_int_int_field_1;
    printf("%d -- %d--\n", a, b);
  }
  
}

