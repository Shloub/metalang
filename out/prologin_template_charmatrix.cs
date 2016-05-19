using System;
using System.Collections.Generic;

public class prologin_template_charmatrix
{
  static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out0 = 0;
    for (int i = 0; i < taille_y; i++)
    {
        for (int j = 0; j < taille_x; j++)
        {
            out0 += (int)(tableau[i][j]) * (i + j * 2);
            Console.Write(tableau[i][j]);
        }
        Console.Write("--\n");
    }
    return out0;
  }
  
  
  public static void Main(String[] args)
  {
    int taille_x = int.Parse(Console.ReadLine());
    int taille_y = int.Parse(Console.ReadLine());
    char[][] a = new char[taille_y][];
    for (int b = 0; b < taille_y; b++)
      a[b] = Console.ReadLine().ToCharArray();
    char[][] tableau = a;
    Console.Write("" + programme_candidat(tableau, taille_x, taille_y) + "\n");
  }
  
}

