using System;
using System.Collections.Generic;

public class prologin_template_intmatrix
{
  
  
  static int programme_candidat(int[][] tableau, int x, int y)
  {
    int out0 = 0;
    for (int i = 0; i < y; i++)
        for (int j = 0; j < x; j++)
            out0 += tableau[i][j] * (i * 2 + j);
    return out0;
  }
  
  public static void Main(String[] args)
  {
    int taille_x = int.Parse(Console.ReadLine());
    int taille_y = int.Parse(Console.ReadLine());
    int[][] tableau = new int[taille_y][];
    for (int a = 0; a < taille_y; a++)
        tableau[a] = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    Console.Write(programme_candidat(tableau, taille_x, taille_y) + "\n");
  }
  
}

