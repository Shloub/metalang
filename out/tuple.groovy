import java.util.*;

public class tuple
{
  
  static class Tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
  }
  static Tuple_int_int f(Tuple_int_int tuple0)
  {
    Tuple_int_int c = tuple0;
    int a = c.tuple_int_int_field_0;
    int b = c.tuple_int_int_field_1;
    Tuple_int_int d = new Tuple_int_int();
    d.tuple_int_int_field_0 = a + 1;
    d.tuple_int_int_field_1 = b + 1;
    return d;
  }
  
  
  static void main(String[] args)
  {
    Tuple_int_int e = new Tuple_int_int();
    e.tuple_int_int_field_0 = 0;
    e.tuple_int_int_field_1 = 1;
    Tuple_int_int t = f(e);
    Tuple_int_int g = t;
    int a = g.tuple_int_int_field_0;
    int b = g.tuple_int_int_field_1;
    System.out.printf("%s -- %s--\n", a, b);
  }
  
}

