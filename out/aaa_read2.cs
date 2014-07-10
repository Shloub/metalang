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
    int a = int.Parse(Console.ReadLine());
    int len = a;
    Console.Write("" + len + "=len\n");
    int[] b = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    int[] tab = b;
    for (int i = 0 ; i < len; i++)
    {
      Console.Write("" + i + "=>" + tab[i] + " ");
    }
    Console.Write("\n");
    int[] d = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    int[] tab2 = d;
    for (int i_ = 0 ; i_ < len; i_++)
    {
      Console.Write("" + i_ + "==>" + tab2[i_] + " ");
    }
    int e = int.Parse(Console.ReadLine());
    int strlen = e;
    Console.Write("" + strlen + "=strlen\n");
    char[] f = Console.ReadLine().ToCharArray();
    char[] tab4 = f;
    for (int i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      Console.Write("" + tmpc + ":" + c + " ");
      if (tmpc != (char)32)
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[i3] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
      Console.Write(tab4[j]);
  }
  
}

