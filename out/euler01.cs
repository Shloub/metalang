using System;

public class euler01
{
  
  public static void Main(String[] args)
  {
    int sum = 0;
    for (int i = 0; i <= 999; i ++)
      if (i % 3 == 0 || i % 5 == 0)
      sum += i;
    Console.Write("" + sum + "\n");
  }
  
}

