using System;

public class sqrttest
{
  public static int isqrt(int c)
  {
    return (int)Math.Sqrt(c);
  }
  
  
  public static void Main(String[] args)
  {
    Console.Write("" + isqrt(4) + " " + isqrt(16) + " " + isqrt(20) + " " + isqrt(1000) + " " + isqrt(500) + " " + isqrt(10) + " ");
  }
  
}

