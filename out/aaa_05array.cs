using System;

public class aaa_05array
{
  
  public static void Main(String[] args)
  {
    int b = 5;
    int[] a = new int[b];
    for (int i = 0 ; i < b; i++)
    {
      Console.Write(i);
      a[i] = i * 2;
    }
  }
  
}

