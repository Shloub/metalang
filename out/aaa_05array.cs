using System;

public class aaa_05array
{
  public static bool[] id(bool[] b)
  {
    return b;
  }
  
  public static void g(bool[] t, int index)
  {
    t[index] = false;
  }
  
  
  public static void Main(String[] args)
  {
    bool[] a = new bool[5];
    for (int i = 0 ; i < 5; i++)
    {
      Console.Write(i);
      a[i] = (i % 2) == 0;
    }
    bool c = a[0];
    if (c)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
    g(id(a), 0);
    bool d = a[0];
    if (d)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
  }
  
}

