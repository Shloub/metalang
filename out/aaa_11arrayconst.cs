using System;

public class aaa_11arrayconst
{
  static void test(int[] tab, int len)
  {
    for (int i = 0; i < len; i += 1)
        Console.Write(tab[i] + " ");
    Console.Write("\n");
  }
  
  
  public static void Main(String[] args)
  {
    int[] t = new int[5];
    for (int i = 0; i < 5; i += 1)
        t[i] = 1;
    test(t, 5);
  }
  
}

