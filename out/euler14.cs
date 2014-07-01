using System;

public class euler14
{
  public static int next_(int n)
  {
    if ((n % 2) == 0)
      return n / 2;
    else
      return 3 * n + 1;
  }
  
  public static int find(int n, int[] m)
  {
    if (n == 1)
      return 1;
    else if (n >= 1000000)
      return 1 + find(next_(n), m);
    else if (m[n] != 0)
      return m[n];
    else
    {
      m[n] = 1 + find(next_(n), m);
      return m[n];
    }
  }
  
  
  public static void Main(String[] args)
  {
    int a = 1000000;
    int[] m = new int[a];
    for (int j = 0 ; j < a; j++)
      m[j] = 0;
    int max_ = 0;
    int maxi = 0;
    for (int i = 1 ; i <= 999; i ++)
    {
      /* normalement on met 999999 mais ça dépasse les int32... */
      int n2 = find(i, m);
      if (n2 > max_)
      {
        max_ = n2;
        maxi = i;
      }
    }
    Console.Write(max_ + "\n" + maxi + "\n");
  }
  
}

