using System;
using System.Collections.Generic;

public class aaa_missing
{
  
  public static int[] read_int_line(int n)
  {
    int[] a = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    return a;
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
    int[] l0 = read_int_line(1);
    int len = l0[0];
    int[] tab = read_int_line(len);
    int b = result(len, tab);
    Console.Write(b);
  }
  
}

