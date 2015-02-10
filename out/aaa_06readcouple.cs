using System;
using System.Collections.Generic;

public class aaa_06readcouple
{
  
  public static void Main(String[] args)
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int[] h = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
      int a = h[0];
      int b = h[1];
      Console.Write("" + "a = " + a + " b = " + b + "\n");
    }
    int[] l = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    for (int j = 0 ; j <= 9; j ++)
    {
      Console.Write("" + l[j] + "\n");
    }
  }
  
}

