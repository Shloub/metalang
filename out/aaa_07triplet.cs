using System;
using System.Collections.Generic;

public class aaa_07triplet
{
  
  public static void Main(String[] args)
  {
    for (int i = 1; i < 4; i += 1)
    {
        int[] d = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
        int a = d[0];
        int b = d[1];
        int c = d[2];
        Console.Write("a = " + a + " b = " + b + "c =" + c + "\n");
    }
    int[] l = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int j = 0; j < 10; j += 1)
        Console.Write(l[j] + "\n");
  }
  
}

