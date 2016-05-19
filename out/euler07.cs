using System;

public class euler07
{
  static bool divisible(int n, int[] t, int size)
  {
    for (int i = 0; i < size; i++)
      if (n % t[i] == 0)
      return true;
    return false;
  }
  
  static int find(int n, int[] t, int used, int nth)
  {
    while (used != nth)
      if (divisible(n, t, used))
      n++;
    else
    {
        t[used] = n;
        n++;
        used++;
    }
    return t[used - 1];
  }
  
  
  public static void Main(String[] args)
  {
    int n = 10001;
    int[] t = new int[n];
    for (int i = 0; i < n; i++)
      t[i] = 2;
    Console.Write("" + find(3, t, 1, n) + "\n");
  }
  
}

