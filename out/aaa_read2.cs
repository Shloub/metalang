using System;
using System.Collections.Generic;

public class aaa_read2
{
  
  
  
  
  
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static int[] read_int_line(int n)
  {
    return new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
  }
  
  public static char[] read_char_line(int n)
  {
    return Console.ReadLine().ToCharArray();
  }
  
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void Main(String[] args)
  {
    int len = read_int();
    Console.Write(len);
    Console.Write("=len\n");
    int[] tab = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      Console.Write(i);
      Console.Write("=>");
      int a = tab[i];
      Console.Write(a);
      Console.Write(" ");
    }
    Console.Write("\n");
    int[] tab2 = read_int_line(len);
    for (int i_ = 0 ; i_ < len; i_++)
    {
      Console.Write(i_);
      Console.Write("==>");
      int b = tab2[i_];
      Console.Write(b);
      Console.Write(" ");
    }
    int strlen = read_int();
    Console.Write(strlen);
    Console.Write("=strlen\n");
    char[] tab4 = read_char_line(strlen);
    for (int i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      Console.Write(tmpc);
      Console.Write(":");
      Console.Write(c);
      Console.Write(" ");
      if (tmpc != (char)32)
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[i3] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
    {
      char d = tab4[j];
      Console.Write(d);
    }
  }
  
}

