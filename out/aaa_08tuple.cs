using System;
using System.Collections.Generic;

public class aaa_08tuple
{
  public class tuple_int_int {
    public int tuple_int_int_field_0;
    public int tuple_int_int_field_1;
  }
  public class toto {
    public tuple_int_int foo;
    public int bar;
  }
  
  public static void Main(String[] args)
  {
    int bar_ = int.Parse(Console.ReadLine());
    int[] c = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    tuple_int_int d = new tuple_int_int();
    d.tuple_int_int_field_0 = c[0];
    d.tuple_int_int_field_1 = c[1];
    toto t = new toto();
    t.foo = d;
    t.bar = bar_;
    tuple_int_int e = t.foo;
    int a = e.tuple_int_int_field_0;
    int b = e.tuple_int_int_field_1;
    Console.Write(a + " " + b + " " + t.bar + "\n");
  }
  
}

