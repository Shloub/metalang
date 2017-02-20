using System;
using System.Collections.Generic;

public class aaa_read2
{
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  
  public static void Main(String[] args)
  {
    int len = int.Parse(Console.ReadLine());
    Console.Write(len + "=len\n");
    int[] tab = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int i = 0; i < len; i++)
        Console.Write(i + "=>" + tab[i] + " ");
    Console.Write("\n");
    int[] tab2 = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int i_ = 0; i_ < len; i_++)
        Console.Write(i_ + "==>" + tab2[i_] + " ");
    int strlen = int.Parse(Console.ReadLine());
    Console.Write(strlen + "=strlen\n");
    char[] tab4 = Console.ReadLine().ToCharArray();
    for (int i3 = 0; i3 < strlen; i3++)
    {
        char tmpc = tab4[i3];
        int c = (int)(tmpc);
        Console.Write(tmpc + ":" + c + " ");
        if (tmpc != (char)32)
            c = (c - (int)('a') + 13) % 26 + (int)('a');
        tab4[i3] = (char)(c);
    }
    for (int j = 0; j < strlen; j++)
        Console.Write(tab4[j]);
  }
  
}

