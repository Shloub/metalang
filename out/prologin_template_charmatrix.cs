using System;
using System.Collections.Generic;

public class prologin_template_charmatrix
{
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
    char[][] e = new char[taille_y][];
    for (int f = 0 ; f < taille_y; f++)
      e[f] = Console.ReadLine().ToCharArray();
    char[][] tableau = e;
    Console.Write("" + programme_candidat(tableau, taille_x, taille_y) + "\n");
  }
  
}

