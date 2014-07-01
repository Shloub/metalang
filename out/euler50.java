import java.util.*;

public class euler50
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    if (a < b)
      return a;
    return b;
  }
  
  public static int eratostene(int[] t, int max_)
  {
    int n = 0;
    for (int i = 2 ; i < max_; i++)
      if (t[i] == i)
    {
      n ++;
      int j = i * i;
      if (j / i == i)
      {
        /* overflow test */
        while (j < max_ && j > 0)
        {
          t[j] = 0;
          j += i;
        }
      }
    }
    return n;
  }
  
  
  public static void main(String args[])
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
    System.out.printf("%d == %d\n", l, nprimes);
    int[] sum = new int[nprimes];
    for (int i_ = 0 ; i_ < nprimes; i_++)
      sum[i_] = primes[i_];
    int maxl = 0;
    boolean process = true;
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
          stop = min2(stop, i);
      }
      len ++;
    }
    System.out.printf("%d\n%d\n", resp, maxl);
  }
  
}

