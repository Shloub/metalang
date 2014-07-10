using System;

public class sqrttest
{
  public static int isqrt(int c)
  {
    return (int)Math.Sqrt(c);
  }
  
  
  public static void Main(String[] args)
  {
    int b = 4;
    int a = (int)Math.Sqrt(b);
    Console.Write("" + a + " ");
    int e = 16;
    int d = (int)Math.Sqrt(e);
    Console.Write("" + d + " ");
    int g = 20;
    int f = (int)Math.Sqrt(g);
    Console.Write("" + f + " ");
    int i = 1000;
    int h = (int)Math.Sqrt(i);
    Console.Write("" + h + " ");
    int k = 500;
    int j = (int)Math.Sqrt(k);
    Console.Write("" + j + " ");
    int m = 10;
    int l = (int)Math.Sqrt(m);
    Console.Write("" + l + " ");
  }
  
}

