object affect_param
{
  
  def foo(_a : Int){
    var a = _a;
    a = 4;
  }
  
  
  def main(args : Array[String])
  {
    var a: Int = 0;
    foo(a);
    printf("%d\n", a);
  }
  
}

