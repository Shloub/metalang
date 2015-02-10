using System;

public class euler50
{
  static int eratostene(int[] t, int max0)
  {
    int n = 0;
    for (int i = 2 ; i < max0; i++)
      if (t[i] == i)
    {
      n ++;
      if (max0 / i > i)
      {
        int j = i * i;
        while (j < max0 && j > 0)
        {
          t[j] = 0;
          j += i;
        }
      }
    }
    return n;
  }
  
  
  public static void Main(String[] args)
  {
    int maximumprimes = 1000001;
    int[] era = new int[maximumprimes];
    for (int j = 0 ; j < maximumprimes; j++)
      era[j] = j;
    int nprimes = eratostene(era, maximumprimes);
    int[] primes = new int[nprimes];
    for (int o = 0 ; o < nprimes; o++)
      primes[o] = 0;
    int l = 0;
    for (int k = 2 ; k < maximumprimes; k++)
      if (era[k] == k)
    {
      primes[l] = k;
      l ++;
    }
    Console.Write("" + l + " == " + nprimes + "\n");
    int[] sum = new int[nprimes];
    for (int i_ = 0 ; i_ < nprimes; i_++)
      sum[i_] = primes[i_];
    int maxl = 0;
    bool process = true;
    int stop = maximumprimes - 1;
    int len = 1;
    int resp = 1;
    while (process)
    {
      process = false;
      for (int i = 0 ; i <= stop; i ++)
        if (i + len < nprimes)
      {
        sum[i] = sum[i] + primes[i + len];
        if (maximumprimes > sum[i])
        {
          process = true;
          if (era[sum[i]] == sum[i])
          {
            maxl = len;
            resp = sum[i];
          }
        }
        else
          stop = Math.Min(stop, i);
      }
      len ++;
    }
    Console.Write("" + resp + "\n" + maxl + "\n");
  }
  
}

