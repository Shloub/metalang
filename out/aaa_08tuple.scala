object aaa_08tuple
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

  class Tuple_int_int(_tuple_int_int_field_0: Int, _tuple_int_int_field_1: Int){
    var tuple_int_int_field_0: Int=_tuple_int_int_field_0;
    var tuple_int_int_field_1: Int=_tuple_int_int_field_1;
  }
  
  class Toto(_foo: Tuple_int_int, _bar: Int){
    var foo: Tuple_int_int=_foo;
    var bar: Int=_bar;
  }
  
  
  def main(args : Array[String])
  {
    var bar_U = read_int()
    skip();
    var c = read_int()
    skip();
    var d = read_int()
    skip();
    var e = new Tuple_int_int(c, d);
    var t = new Toto(e, bar_U);
    var f: Tuple_int_int = t.foo;
    var a: Int = f.tuple_int_int_field_0;
    var b: Int = f.tuple_int_int_field_1;
    printf("%d %d %d\n", a, b, t.bar);
  }
  
}

