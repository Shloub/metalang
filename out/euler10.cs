using System;

public class euler10
{
  public static int eratostene(int[] t, int max_)
  {
    int sum = 0;
    for (int i = 2 ; i < max_; i++)
      if (t[i] == i)
    {
      sum += i;
      int j = i * i;
      /*
			detect overflow
			*/
      if (j / i == i)
        while (j < max_ && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
    return sum;
  }
  
  
  public static void Main(String[] args)
  {
    int n = 100000;
    /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
    int[] t = new int[n];
    for (int i = 0 ; i < n; i++)
      t[i] = i;
    t[1] = 0;
    int a = eratostene(t, n);
    Console.Write(a);
    Console.Write("\n");
  }
  
}

