using System;

public class sqrttest
{
  
  public static int isqrt(int c)
  {
    return (int)Math.Sqrt(c);
  }
  
  
  public static void Main(String[] args)
  {
    int a = isqrt(4);
    Console.Write(a);
    Console.Write(" ");
    int b = isqrt(16);
    Console.Write(b);
    Console.Write(" ");
    int d = isqrt(20);
    Console.Write(d);
    Console.Write(" ");
    int e = isqrt(1000);
    Console.Write(e);
    Console.Write(" ");
    int f = isqrt(500);
    Console.Write(f);
    Console.Write(" ");
    int g = isqrt(10);
    Console.Write(g);
    Console.Write(" ");
  }
  
}

