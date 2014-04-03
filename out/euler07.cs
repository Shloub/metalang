using System;

public class euler07
{
  public static bool divisible(int n, int[] t, int size)
  {
    for (int i = 0 ; i < size; i++)
      if ((n % t[i]) == 0)
      return true;
    return false;
  }
  
  public static int find(int n, int[] t, int used, int nth)
  {
    while (used != nth)
      if (divisible(n, t, used))
      n ++;
    else
    {
      t[used] = n;
      n ++;
      used ++;
    }
    return t[used - 1];
  }
  
  
  public static void Main(String[] args)
  {
    int a = 10001;
    int[] t = new int[a];
    for (int i = 0 ; i < a; i++)
      t[i] = 2;
    int b = find(3, t, 1, 10001);
    Console.Write(b);
    Console.Write("\n");
  }
  
}

