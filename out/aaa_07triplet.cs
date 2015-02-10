using System;
using System.Collections.Generic;

public class aaa_07triplet
{
  
  public static void Main(String[] args)
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int[] k = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
      int a = k[0];
      int b = k[1];
      int c = k[2];
      Console.Write("" + "a = " + a + " b = " + b + "c =" + c + "\n");
    }
    int[] l = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    for (int j = 0 ; j <= 9; j ++)
    {
      Console.Write("" + l[j] + "\n");
    }
  }
  
}

