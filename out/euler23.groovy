import java.util.*

int eratostene(int[] t, int max0)
{
  int n = 0
  for (int i = 2 ; i < max0; i++)
    if (t[i] == i)
  {
    n ++;
    int j = i * i
    while (j < max0 && j > 0)
    {
      t[j] = 0
      j += i;
    }
  }
  return n
}

int fillPrimesFactors(int[] t, int n, int[] primes, int nprimes)
{
  for (int i = 0 ; i < nprimes; i++)
  {
    int d = primes[i]
    while ((n % d) == 0)
    {
      t[d] = t[d] + 1
      n /= d;
    }
    if (n == 1)
      return primes[i]
  }
  return n
}

int sumdivaux2(int[] t, int n, int i)
{
  while (i < n && t[i] == 0)
    i ++;
  return i
}

int sumdivaux(int[] t, int n, int i)
{
  if (i > n)
    return 1
  else if (t[i] == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
  else
  {
    int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
    int out0 = 0
    int p = i
    for (int j = 1 ; j <= t[i]; j ++)
    {
      out0 += p;
      p *= i;
    }
    return (out0 + 1) * o
  }
}

int sumdiv(int nprimes, int[] primes, int n)
{
  int[] t = new int[n + 1]
  for (int i = 0 ; i < n + 1; i++)
    t[i] = 0
  int max0 = fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max0, 0)
}



int maximumprimes = 30001
int[] era = new int[maximumprimes]
for (int s = 0 ; s < maximumprimes; s++)
  era[s] = s
int nprimes = eratostene(era, maximumprimes)
int[] primes = new int[nprimes]
for (int t = 0 ; t < nprimes; t++)
  primes[t] = 0
int l = 0
for (int k = 2 ; k < maximumprimes; k++)
  if (era[k] == k)
{
  primes[l] = k
  l ++;
}
int n = 100
/* 28124 ça prend trop de temps mais on arrive a passer le test */
boolean[] abondant = new boolean[n + 1]
for (int p = 0 ; p < n + 1; p++)
  abondant[p] = false
boolean[] summable = new boolean[n + 1]
for (int q = 0 ; q < n + 1; q++)
  summable[q] = false
int sum = 0
for (int r = 2 ; r <= n; r ++)
{
  int other = sumdiv(nprimes, primes, r) - r
  if (other > r)
    abondant[r] = true
}
for (int i = 1 ; i <= n; i ++)
  for (int j = 1 ; j <= n; j ++)
    if (abondant[i] && abondant[j] && i + j <= n)
  summable[i + j] = true
for (int o = 1 ; o <= n; o ++)
  if (!summable[o])
  sum += o;
System.out.printf("\n%s\n", sum);
