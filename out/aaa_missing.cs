using System;
using System.Collections.Generic;

public class aaa_missing
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static int[] read_int_line(int n)
  {
    return new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
  }
  
  /*
  Ce test a été généré par Metalang.
*/
  public static int result(int len, int[] tab)
  {
    bool[] tab2 = new bool[len];
    for (int i = 0 ; i < len; i++)
      tab2[i] = false;
    for (int i1 = 0 ; i1 < len; i1++)
      tab2[tab[i1]] = true;
    for (int i2 = 0 ; i2 < len; i2++)
      if (!tab2[i2])
      return i2;
    return -1;
  }
  
  
  public static void Main(String[] args)
  {
    int a = int.Parse(Console.ReadLine());
    int len = a;
    Console.Write("" + len + "\n");
    int[] b = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    int[] tab = b;
    Console.Write(result(len, tab));
  }
  
}

