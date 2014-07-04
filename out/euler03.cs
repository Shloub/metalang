using System;

public class euler03
{
  
  public static void Main(String[] args)
  {
    int maximum = 1;
    int b0 = 2;
    int a = 408464633;
    while (a != 1)
    {
      int b = b0;
      bool found = false;
      while (b * b < a)
      {
        if ((a % b) == 0)
        {
          a /= b;
          b0 = b;
          b = a;
          found = true;
        }
        b ++;
      }
      if (!found)
      {
        Console.Write(a + "\n");
        a = 1;
      }
    }
  }
  
}

