using System;
using System.Collections.Generic;

public class aaa_readints
{
  
  public static void Main(String[] args)
  {
    int len = int.Parse(Console.ReadLine());
    Console.Write("" + len + "=len\n");
    int[] tab1 = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    for (int i = 0 ; i < len; i++)
    {
      Console.Write("" + i + "=>" + tab1[i] + "\n");
    }
    len = int.Parse(Console.ReadLine());
    int[][] g = new int[len - 1][];
    for (int h = 0 ; h < len - 1; h++)
      g[h] = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    int[][] tab2 = g;
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        Console.Write("" + tab2[i][j] + " ");
      }
      Console.Write("\n");
    }
  }
  
}

