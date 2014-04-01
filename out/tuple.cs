using System;

public class tuple
{
  public class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  public static tuple_int_int f(tuple_int_int tuple_)
  {
    tuple_int_int c = tuple_;
    int a = c.tuple_int_int_field_0;
    int b = c.tuple_int_int_field_1;
    tuple_int_int e = new tuple_int_int();
    e.tuple_int_int_field_0 = a + 1;
    e.tuple_int_int_field_1 = b + 1;
    return e;
  }
  
  
  public static void Main(String[] args)
  {
    tuple_int_int g = new tuple_int_int();
    g.tuple_int_int_field_0 = 0;
    g.tuple_int_int_field_1 = 1;
    tuple_int_int t = f(g);
    tuple_int_int d = t;
    int a = d.tuple_int_int_field_0;
    int b = d.tuple_int_int_field_1;
    Console.Write(a);
    Console.Write(" -- ");
    Console.Write(b);
    Console.Write("--\n");
  }
  
}

