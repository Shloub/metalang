using System;
using System.Collections.Generic;

public class aaa_readints
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static int[] read_int_line(int n)
  {
    return new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
      tab[z] = read_int_line(x);
    return tab;
  }
  
  
  public static void Main(String[] args)
  {
    int len = read_int();
    Console.Write("" + len + "=len\n");
    int[] tab1 = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      Console.Write("" + i + "=>" + tab1[i] + "\n");
    }
    len = read_int();
    int[][] tab2 = read_int_matrix(len, len - 1);
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

