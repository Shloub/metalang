object tuple
{
  
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

