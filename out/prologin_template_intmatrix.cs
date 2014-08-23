using System;
using System.Collections.Generic;

public class prologin_template_intmatrix
{
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int[] a = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
      tab[z] = a;
    }
    return tab;
  }
  
  public static int programme_candidat(int[][] tableau, int x, int y)
  {
    int out_ = 0;
    for (int i = 0 ; i < y; i++)
      for (int j = 0 ; j < x; j++)
        out_ += tableau[i][j] * (i * 2 + j);
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille_x = int.Parse(Console.ReadLine());
    int taille_y = int.Parse(Console.ReadLine());
    int[][] tableau = read_int_matrix(taille_x, taille_y);
    Console.Write("" + programme_candidat(tableau, taille_x, taille_y) + "\n");
  }
  
}

