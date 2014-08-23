using System;
using System.Collections.Generic;

public class prologin_template_intlist
{
  public static int programme_candidat(int[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
      out_ += tableau[i];
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille = int.Parse(Console.ReadLine());
    int[] tableau = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    Console.Write("" + programme_candidat(tableau, taille) + "\n");
  }
  
}

