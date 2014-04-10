import java.util.*;

public class euler21
{
  static Scanner scanner = new Scanner(System.in);
  public static int eratostene(int[] t, int max_)
  {
    int n = 0;
    for (int i = 2 ; i < max_; i++)
      if (t[i] == i)
    {
      n ++;
      int j = i * i;
      while (j < max_ && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
    return n;
  }
  
  public static int fillPrimesFactors(int[] t, int n, int[] primes, int nprimes)
  {
    for (int i = 0 ; i < nprimes; i++)
    {
      int d = primes[i];
      while ((n % d) == 0)
      {
        t[d] = t[d] + 1;
        n /= d;
      }
      if (n == 1)
        return primes[i];
    }
    return n;
  }
  
  public static int sumdivaux2(int[] t, int n, int i)
  {
    while (i < n && t[i] == 0)
      i ++;
    return i;
  }
  
  public static int sumdivaux(int[] t, int n, int i)
  {
    if (i > n)
      return 1;
    else if (t[i] == 0)
      return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    else
    {
      int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
      int out_ = 0;
      int p = i;
      for (int j = 1 ; j <= t[i]; j ++)
      {
        out_ += p;
        p *= i;
      }
      return (out_ + 1) * o;
    }
  }
  
  public static int sumdiv(int nprimes, int[] primes, int n)
  {
    int a = n + 1;
    int[] t = new int[a];
    for (int i = 0 ; i < a; i++)
      t[i] = 0;
    int max_ = fillPrimesFactors(t, n, primes, nprimes);
    return sumdivaux(t, max_, 0);
  }
  
  
  public static void main(String args[])
  {
    int maximumprimes = 10001;
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
    System.out.printf("%d%s%d%s", l, " == ", nprimes, "\n");
    int sum = 0;
    for (int n = 2 ; n <= 10000; n ++)
    {
      int other = sumdiv(nprimes, primes, n) - n;
      if (other > n)
      {
        int othersum = sumdiv(nprimes, primes, other) - other;
        if (othersum == n)
        {
          System.out.printf("%d%s%d%s", other, " & ", n, "\n");
          sum += other + n;
        }
      }
    }
    System.out.printf("%s%d%s", "\n", sum, "\n");
  }
  
}

