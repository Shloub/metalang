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
    int[] i = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    tuple_int_int k = new tuple_int_int();
    k.tuple_int_int_field_0 = i[0];
    k.tuple_int_int_field_1 = i[1];
    toto t = new toto();
    t.foo = k;
    t.bar = bar_;
    tuple_int_int j = t.foo;
    int a = j.tuple_int_int_field_0;
    int b = j.tuple_int_int_field_1;
    Console.Write("" + a + " " + b + " " + t.bar + "\n");
  }
  
}

