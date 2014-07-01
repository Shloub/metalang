using System;

public class euler02
{
  
  
  public static void Main(String[] args)
  {
    int a = 1;
    int b = 2;
    int sum = 0;
    while (a < 4000000)
    {
      if ((a % 2) == 0)
        sum += a;
      int c = a;
      a = b;
      b += c;
    }
    Console.Write(sum + "\n");
  }
  
}

