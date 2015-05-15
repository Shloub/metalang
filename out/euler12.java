import java.util.*;

public class euler12
{
  
  static int eratostene(int[] t, int max0)
  {
    int n = 0;
    for (int i = 2 ; i < max0; i++)
      if (t[i] == i)
    {
      int j = i * i;
      n ++;
      while (j < max0 && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
    return n;
  }
  
  static int fillPrimesFactors(int[] t, int n, int[] primes, int nprimes)
  {
    for (int i = 0 ; i < nprimes; i++)
    {
      int d = primes[i];
      while (n % d == 0)
      {
        t[d] = t[d] + 1;
        n /= d;
      }
      if (n == 1)
        return primes[i];
    }
    return n;
  }
  
  static int find(int ndiv2)
  {
    int maximumprimes = 110;
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
    for (int n = 1 ; n <= 10000; n ++)
    {
      int[] primesFactors = new int[n + 2];
      for (int m = 0 ; m < n + 2; m++)
        primesFactors[m] = 0;
      int max0 = Math.max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
      primesFactors[2] --;
      int ndivs = 1;
      for (int i = 0 ; i <= max0; i ++)
        if (primesFactors[i] != 0)
        ndivs *= 1 + primesFactors[i];
      if (ndivs > ndiv2)
        return n * (n + 1) / 2;
      /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
    }
    return 0;
  }
  
  
  public static void main(String args[])
  {
    System.out.printf("%d\n", find(500));
  }
  
}

