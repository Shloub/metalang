using System;
using System.Collections.Generic;

public class aaa_06readcouple
{
  
  public static void Main(String[] args)
  {
    for (int i = 1; i < 4; i += 1)
    {
        int[] c = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
        int a = c[0];
        int b = c[1];
        Console.Write("a = " + a + " b = " + b + "\n");
    }
    int[] l = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll(int.Parse).ToArray();
    for (int j = 0; j < 10; j += 1)
        Console.Write(l[j] + "\n");
  }
  
}

