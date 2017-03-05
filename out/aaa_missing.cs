using System;
using System.Collections.Generic;

public class aaa_missing
{
  /*
  Ce test a été généré par Metalang.
*/
  static int result(int len, int[] tab)
  {
    bool[] tab2 = new bool[len];
    for (int i = 0; i < len; i++)
        tab2[i] = false;
    for (int i1 = 0; i1 < len; i1++)
    {
        Console.Write(tab[i1] + " ");
        tab2[tab[i1]] = true;
    }
    Console.Write("\n");
    for (int i2 = 0; i2 < len; i2++)
        if (!tab2[i2])
            return i2;
    return -1;
  }
  
  public static void Main(String[] args)
  {
    int len = int.Parse(Console.ReadLine());
    Console.Write(len + "\n");
    int[] tab = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    Console.Write(result(len, tab) + "\n");
  }
  
}

