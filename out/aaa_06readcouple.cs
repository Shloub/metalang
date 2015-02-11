using System;
using System.Collections.Generic;

public class aaa_06readcouple
{
  
  public static void Main(String[] args)
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int[] c = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
      int a = c[0];
      int b = c[1];
      Console.Write("a = " + a + " b = " + b + "\n");
    }
    int[] l = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int j = 0 ; j <= 9; j ++)
    {
      Console.Write("" + l[j] + "\n");
    }
  }
  
}

