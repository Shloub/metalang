using System;
using System.Collections.Generic;

public class prologin_template_2charline2
{
  static int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
  {
    int out0 = 0;
    for (int i = 0; i < taille1; i++)
    {
        out0 += (int)(tableau1[i]) * i;
        Console.Write(tableau1[i]);
    }
    Console.Write("--\n");
    for (int j = 0; j < taille2; j++)
    {
        out0 += (int)(tableau2[j]) * j * 100;
        Console.Write(tableau2[j]);
    }
    Console.Write("--\n");
    return out0;
  }
  
  public static void Main(String[] args)
  {
    int taille1 = int.Parse(Console.ReadLine());
    int taille2 = int.Parse(Console.ReadLine());
    char[] tableau1 = Console.ReadLine().ToCharArray();
    char[] tableau2 = Console.ReadLine().ToCharArray();
    Console.Write(programme_candidat(tableau1, taille1, tableau2, taille2) + "\n");
  }
  
}

