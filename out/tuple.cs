using System;

public class tuple
{
  public class tuple_int_int {
    public int tuple_int_int_field_0;
    public int tuple_int_int_field_1;
  }
  static tuple_int_int f(tuple_int_int tuple0)
  {
    tuple_int_int c = tuple0;
    int a = c.tuple_int_int_field_0;
    int b = c.tuple_int_int_field_1;
    tuple_int_int d = new tuple_int_int();
    d.tuple_int_int_field_0 = a + 1;
    d.tuple_int_int_field_1 = b + 1;
    return d;
  }
  
  public static void Main(String[] args)
  {
    tuple_int_int e = new tuple_int_int();
    e.tuple_int_int_field_0 = 0;
    e.tuple_int_int_field_1 = 1;
    tuple_int_int t = f(e);
    tuple_int_int g = t;
    int a = g.tuple_int_int_field_0;
    int b = g.tuple_int_int_field_1;
    Console.Write(a + " -- " + b + "--\n");
  }
  
}

