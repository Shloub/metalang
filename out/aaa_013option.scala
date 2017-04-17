object aaa_013option
{
  
  class Foo(_a: Int, _b: Option[Int], _c: Option[Array[Int]], _d: Array[Option[Int]], _e: Array[Int], _f: Option[Foo], _g: Array[Option[Foo]], _h: Option[Array[Foo]]){
    var a: Int=_a;
    var b: Option[Int]=_b;
    var c: Option[Array[Int]]=_c;
    var d: Array[Option[Int]]=_d;
    var e: Array[Int]=_e;
    var f: Option[Foo]=_f;
    var g: Array[Option[Foo]]=_g;
    var h: Option[Array[Foo]]=_h;
  }
  
  def default0(a : Option[Int], b : Option[Foo], c : Array[Option[Int]], d : Array[Option[Foo]], e : Option[Array[Int]], f : Option[Array[Foo]]): Int = {
    return 0;
  }
  
  def aa(b : Foo){
    
  }
  
  def main(args : Array[String])
  {
    var a: Option[Int] = None;
    printf("___\n");
  }
  
}

