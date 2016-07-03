using System;
using System.Collections.Generic;

public class prologin_template_charline
{
  static int programme_candidat(char[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0; i < taille; i++)
    {
        out0 += (int)(tableau[i]) * i;
        Console.Write(tableau[i]);
    }
    Console.Write("--\n");
    return out0;
  }
  
  
  public static void Main(String[] args)
  {
    int taille = int.Parse(Console.ReadLine());
    char[] tableau = Console.ReadLine().ToCharArray();
    Console.Write(programme_candidat(tableau, taille) + "\n");
  }
  
}

