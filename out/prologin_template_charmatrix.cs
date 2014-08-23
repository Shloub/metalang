using System;
using System.Collections.Generic;

public class prologin_template_charmatrix
{
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
    {
      char[] a = Console.ReadLine().ToCharArray();
      tab[z] = a;
    }
    return tab;
  }
  
  public static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille_y; i++)
    {
      for (int j = 0 ; j < taille_x; j++)
      {
        out_ += tableau[i][j] * (i + j * 2);
        Console.Write(tableau[i][j]);
      }
      Console.Write("--\n");
    }
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille_x = int.Parse(Console.ReadLine());
    int taille_y = int.Parse(Console.ReadLine());
    char[][] tableau = read_char_matrix(taille_x, taille_y);
    Console.Write("" + programme_candidat(tableau, taille_x, taille_y) + "\n");
  }
  
}

