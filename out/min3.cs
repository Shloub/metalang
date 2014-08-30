using System;

public class min3
{
  public static int min2(int a, int b)
  {
    return Math.Min(a, b);
  }
  
  
  public static void Main(String[] args)
  {
    Console.Write("" + min2(min2(2, 3), 4) + " " + min2(min2(2, 4), 3) + " " + min2(min2(3, 2), 4) + " " + min2(min2(3, 4), 2) + " " + min2(min2(4, 2), 3) + " " + min2(min2(4, 3), 2) + "\n");
  }
  
}

