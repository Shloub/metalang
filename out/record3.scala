object record3
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
  
  def result(t : Array[Toto], len : Int): Int = {
    var j: Int=0;
    var out0: Int = 0;
    for (j <- 0 to len - 1)
    {
        t(j).blah = t(j).blah + 1;
        out0 = out0 + t(j).foo + t(j).blah * t(j).bar + t(j).bar * t(j).foo;
    }
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var t :Array[Toto] = new Array[Toto](4);
    for (i <- 0 to 4 - 1)
      t(i) = mktoto(i);
    t(0).bar = read_int()
    skip();
    t(1).blah = read_int()
    var titi: Int = result(t, 4);
    printf("%d%d", titi, t(2).blah);
  }
  
}

