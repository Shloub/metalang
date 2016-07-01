using System;

public class euler21
{
  static int eratostene(int[] t, int max0)
  {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
            int j = i * i;
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
    for (int i = 0; i < nprimes; i += 1)
    {
        int d = primes[i];
        while (n % d == 0)
        {
            t[d] += 1;
            n /= d;
        }
        if (n == 1)
            return primes[i];
    }
    return n;
  }
  
  static int sumdivaux2(int[] t, int n, int i)
  {
    while (i < n && t[i] == 0)
        i += 1;
    return i;
  }
  
  static int sumdivaux(int[] t, int n, int i)
  {
    if (i > n)
        return 1;
    else if (t[i] == 0)
        return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    else
    {
        int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
        int out0 = 0;
        int p = i;
        for (int j = 1; j <= t[i]; j += 1)
        {
            out0 += p;
            p *= i;
        }
        return (out0 + 1) * o;
    }
  }
  
  static int sumdiv(int nprimes, int[] primes, int n)
  {
    int[] t = new int[n + 1];
    for (int i = 0; i <= n; i += 1)
        t[i] = 0;
    int max0 = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max0, 0);
  }
  
  
  public static void Main(String[] args)
  {
    int maximumprimes = 1001;
    int[] era = new int[maximumprimes];
    for (int j = 0; j < maximumprimes; j += 1)
        era[j] = j;
    int nprimes = eratostene(era, maximumprimes);
    int[] primes = new int[nprimes];
    for (int o = 0; o < nprimes; o += 1)
        primes[o] = 0;
    int l = 0;
    for (int k = 2; k < maximumprimes; k += 1)
        if (era[k] == k)
        {
            primes[l] = k;
            l += 1;
        }
    Console.Write(l + " == " + nprimes + "\n");
    int sum = 0;
    for (int n = 2; n <= 1000; n += 1)
    {
        int other = sumdiv(nprimes, primes, n) - n;
        if (other > n)
        {
            int othersum = sumdiv(nprimes, primes, other) - other;
            if (othersum == n)
            {
                Console.Write(other + " & " + n + "\n");
                sum += other + n;
            }
        }
    }
    Console.Write("\n" + sum + "\n");
  }
  
}

