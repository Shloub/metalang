object record2
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
  
  class Toto(_foo: Int, _bar: Int, _blah: Int){
    var foo: Int=_foo;
    var bar: Int=_bar;
    var blah: Int=_blah;
  }
  
  def mktoto(v1 : Int): Toto = {
    var t: Toto = new Toto(v1, 0, 0);
    return t;
  }
  
  def result(t : Toto): Int = {
    t.blah = t.blah + 1;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  def main(args : Array[String])
  {
    var t: Toto = mktoto(4);
    t.bar = read_int();
    skip();
    t.blah = read_int();
    printf("%d", result(t));
  }
  
}

