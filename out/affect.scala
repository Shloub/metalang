object affect
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
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
  class Toto(_foo: Int, _bar: Int, _blah: Int){
    var foo: Int=_foo;
    var bar: Int=_bar;
    var blah: Int=_blah;
  }
  
  def mktoto(v1 : Int): Toto = {
    var t: Toto = new Toto(v1, v1, v1);
    return t;
  }
  
  def mktoto2(v1 : Int): Toto = {
    var t: Toto = new Toto(v1 + 3, v1 + 2, v1 + 1);
    return t;
  }
  
  def result(t_0 : Toto, t2_0 : Toto): Int = {
    var t: Toto = t_0;
    var t2: Toto = t2_0;
    var t3: Toto = new Toto(0, 0, 0);
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah = t.blah + 1;
    var len: Int = 1;
    var cache0 :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
    
        cache0(i) = -i;
    var cache1 :Array[Int] = new Array[Int](len);
    for (j <- 0 to len - 1)
    
        cache1(j) = j;
    var cache2: Array[Int] = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  def main(args : Array[String])
  {
    var t: Toto = mktoto(4);
    var t2: Toto = mktoto(5);
    t.bar = read_int();
    skip();
    t.blah = read_int();
    skip();
    t2.bar = read_int();
    skip();
    t2.blah = read_int();
    printf("%d%d", result(t, t2), t.blah);
  }
  
}

