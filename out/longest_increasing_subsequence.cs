using System;
using System.Collections.Generic;

public class longest_increasing_subsequence
{
  static int dichofind(int len, int[] tab, int tofind, int a, int b)
  {
    if (a >= b - 1)
        return a;
    else
    {
        int c = (a + b) / 2;
        if (tab[c] < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
  }
  
  static int process(int len, int[] tab)
  {
    int[] size = new int[len];
    for (int j = 0; j < len; j++)
        if (j == 0)
            size[j] = 0;
        else
            size[j] = len * 2;
    for (int i = 0; i < len; i++)
    {
        int k = dichofind(len, size, tab[i], 0, len - 1);
        if (size[k + 1] > tab[i])
            size[k + 1] = tab[i];
    }
    for (int l = 0; l < len; l++)
        Console.Write(size[l] + " ");
    for (int m = 0; m < len; m++)
    {
        int k = len - 1 - m;
        if (size[k] != len * 2)
            return k;
    }
    return 0;
  }
  
  public static void Main(String[] args)
  {
    int n = int.Parse(Console.ReadLine());
    for (int i = 1; i <= n; i++)
    {
        int len = int.Parse(Console.ReadLine());
        Console.Write(process(len, new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray()) + "\n");
    }
  }
  
}

