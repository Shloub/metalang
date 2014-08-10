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
    int c = 5;
    bool[] a = new bool[c];
    for (int i = 0 ; i < c; i++)
    {
      Console.Write(i);
      a[i] = (i % 2) == 0;
    }
    bool d = a[0];
    if (d)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
    g(id(a), 0);
    bool e = a[0];
    if (e)
      Console.Write("True");
    else
      Console.Write("False");
    Console.Write("\n");
  }
  
}

