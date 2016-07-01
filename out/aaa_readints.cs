using System;
using System.Collections.Generic;

public class aaa_readints
{
  
  public static void Main(String[] args)
  {
    int len = int.Parse(Console.ReadLine());
    Console.Write(len + "=len\n");
    int[] tab1 = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int i = 0; i < len; i += 1)
        Console.Write(i + "=>" + tab1[i] + "\n");
    len = int.Parse(Console.ReadLine());
    int[][] tab2 = new int[len - 1][];
    for (int a = 0; a < len - 1; a += 1)
        tab2[a] = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int i = 0; i < len - 1; i += 1)
    {
        for (int j = 0; j < len; j += 1)
            Console.Write(tab2[i][j] + " ");
        Console.Write("\n");
    }
  }
  
}

