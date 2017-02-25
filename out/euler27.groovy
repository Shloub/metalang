import java.util.*

int eratostene(int[] t, int max0)
{
  int n = 0
  for (int i = 2; i < max0; i++)
      if (t[i] == i)
      {
          n++
          int j = i * i
          while (j < max0 && j > 0)
          {
              t[j] = 0
              j += i
          }
      }
  return n
}

boolean isPrime(int n, int[] primes, int len)
{
  int i = 0
  if (n < 0)
      n = -n
  while (primes[i] * primes[i] < n)
  {
      if (n % primes[i] == 0)
          return false
      i++
  }
  return true
}

int test(int a, int b, int[] primes, int len)
{
  for (int n = 0; n < 201; n++)
  {
      int j = n * n + a * n + b
      if (!isPrime(j, primes, len))
          return n
  }
  return 200
}


int maximumprimes = 1000
int[] era = new int[maximumprimes]
for (int j = 0; j < maximumprimes; j++)
    era[j] = j
int result = 0
int max0 = 0
int nprimes = eratostene(era, maximumprimes)
int[] primes = new int[nprimes]
for (int o = 0; o < nprimes; o++)
    primes[o] = 0
int l = 0
for (int k = 2; k < maximumprimes; k++)
    if (era[k] == k)
    {
        primes[l] = k
        l++
    }
System.out.printf("%d == %d\n", l, nprimes)
int ma = 0
int mb = 0
for (int b = 3; b < 1000; b++)
    if (era[b] == b)
        for (int a = -999; a < 1000; a++)
        {
            int n1 = test(a, b, primes, nprimes)
            int n2 = test(a, -b, primes, nprimes)
            if (n1 > max0)
            {
                max0 = n1
                result = a * b
                ma = a
                mb = b
            }
            if (n2 > max0)
            {
                max0 = n2
                result = -a * b
                ma = a
                mb = -b
            }
        }
System.out.printf("%d %d\n%d\n%d\n", ma, mb, max0, result)

