using System;
using System.Collections.Generic;

public class carre
{
  
  
  
  public static void Main(String[] args)
  {
    int x = int.Parse(Console.ReadLine());
    int y = int.Parse(Console.ReadLine());
    int[][] tab = new int[y][];
    for (int d = 0; d < y; d++)
        tab[d] = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int ix = 1; ix < x; ix++)
        for (int iy = 1; iy < y; iy++)
            if (tab[iy][ix] == 1)
                tab[iy][ix] = Math.Min(Math.Min(tab[iy][ix - 1], tab[iy - 1][ix]), tab[iy - 1][ix - 1]) + 1;
    for (int jy = 0; jy < y; jy++)
    {
        for (int jx = 0; jx < x; jx++)
            Console.Write(tab[jy][jx] + " ");
        Console.Write("\n");
    }
  }
  
}

