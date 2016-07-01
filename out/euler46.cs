using System;

public class euler46
{
  static int eratostene(int[] t, int max0)
  {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
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
    int maximumprimes = 6000;
    int[] era = new int[maximumprimes];
    for (int j_ = 0; j_ < maximumprimes; j_ += 1)
        era[j_] = j_;
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
    bool[] canbe = new bool[maximumprimes];
    for (int i_ = 0; i_ < maximumprimes; i_ += 1)
        canbe[i_] = false;
    for (int i = 0; i < nprimes; i += 1)
        for (int j = 0; j < maximumprimes; j += 1)
        {
            int n = primes[i] + 2 * j * j;
            if (n < maximumprimes)
                canbe[n] = true;
        }
    for (int m = 1; m <= maximumprimes; m += 1)
    {
        int m2 = m * 2 + 1;
        if (m2 < maximumprimes && !canbe[m2])
            Console.Write(m2 + "\n");
    }
  }
  
}

