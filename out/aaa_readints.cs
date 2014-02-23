using System;
using System.Collections.Generic;

public class aaa_readints
{
  
  public static int[] read_int_line(int n)
  {
    int[] a = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    return a;
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int[] out_ = read_int_line(x);
      tab[z] = out_;
    }
    return tab;
  }
  
  
  public static void Main(String[] args)
  {
    int[] l0 = read_int_line(1);
    int len = l0[0];
    Console.Write(len);
    Console.Write("=len\n");
    int[] tab1 = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      Console.Write(i);
      Console.Write("=>");
      int b = tab1[i];
      Console.Write(b);
      Console.Write("\n");
    }
    l0 = read_int_line(1);
    len = l0[0];
    int[][] tab2 = read_int_matrix(len, len - 1);
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        int c = tab2[i][j];
        Console.Write(c);
        Console.Write(" ");
      }
      Console.Write("\n");
    }
  }
  
}

