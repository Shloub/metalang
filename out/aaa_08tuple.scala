object aaa_08tuple
{
  
  class Toto(_foo: (Int, Int), _bar: Int){
    var foo: (Int, Int)=_foo;
    var bar: Int=_bar;
  }
  
  def main(args : Array[String])
  {
    var bar_0: Int = readInt().toInt;
    var t: Toto = new Toto(readf2("{0,number} {1,number}").asInstanceOf[(Long, Long)] match { case x => (x._1.toInt, x._2.toInt) }, bar_0);
    var (a, b) = t.foo;
    printf("%d %d %d\n", a, b, t.bar);
  }
  
}

