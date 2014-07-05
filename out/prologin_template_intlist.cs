using System;
using System.Collections.Generic;

public class prologin_template_intlist
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static int[] read_int_line(int n)
  {
    return new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
  }
  
  public static int programme_candidat(int[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
      out_ += tableau[i];
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille = read_int();
    int[] tableau = read_int_line(taille);
    int a = programme_candidat(tableau, taille);
    Console.Write(a + "\n");
  }
  
}

