using System;
using System.Collections.Generic;

public class prologin_template_2charline
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static char[] read_char_line(int n)
  {
    return Console.ReadLine().ToCharArray();
  }
  
  public static int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille1; i++)
    {
      out_ += tableau1[i] * i;
      char a = tableau1[i];
      Console.Write(a);
    }
    Console.Write("--\n");
    for (int j = 0 ; j < taille2; j++)
    {
      out_ += tableau2[j] * j * 100;
      char b = tableau2[j];
      Console.Write(b);
    }
    Console.Write("--\n");
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int taille1 = read_int();
    char[] tableau1 = read_char_line(taille1);
    int taille2 = read_int();
    char[] tableau2 = read_char_line(taille2);
    int c = programme_candidat(tableau1, taille1, tableau2, taille2);
    Console.Write(c + "\n");
  }
  
}

