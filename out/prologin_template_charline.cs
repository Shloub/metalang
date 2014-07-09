using System;
using System.Collections.Generic;

public class prologin_template_charline
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static char[] read_char_line(int n)
  {
    return Console.ReadLine().ToCharArray();
  }
  
  public static int programme_candidat(char[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
    {
      out_ += tableau[i] * i;
      Console.Write(tableau[i]);
    }
    Console.Write("--\n");
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille = read_int();
    char[] tableau = read_char_line(taille);
    Console.Write("" + programme_candidat(tableau, taille) + "\n");
  }
  
}

