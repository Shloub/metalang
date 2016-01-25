#include <stdio.h>
#include <stdlib.h>


int eratostene(int* t, int max0) {
  int i;
  int n = 0;
  for (i = 2; i < max0; i++)
    if (t[i] == i)
  {
    n++;
    int j = i * i;
    while (j < max0 && j > 0)
    {
      t[j] = 0;
      j += i;
    }
  }
  return n;
}


int isPrime(int n, int* primes, int len) {
  int i = 0;
  if (n < 0)
    n = -n;
  while (primes[i] * primes[i] < n)
  {
    if (n % primes[i] == 0)
      return 0;
    i++;
  }
  return 1;
}


int test(int a, int b, int* primes, int len) {
  int n;
  for (n = 0; n <= 200; n++)
  {
    int j = n * n + a * n + b;
    if (!isPrime(j, primes, len))
      return n;
  }
  return 200;
}

int main(void) {
  int b, a, k, o, j;
  int maximumprimes = 1000;
  int *era = calloc( maximumprimes , sizeof(int));
  for (j = 0; j < maximumprimes; j++)
    era[j] = j;
  int result = 0;
  int max0 = 0;
  int nprimes = eratostene(era, maximumprimes);
  int *primes = calloc( nprimes , sizeof(int));
  for (o = 0; o < nprimes; o++)
    primes[o] = 0;
  int l = 0;
  for (k = 2; k < maximumprimes; k++)
    if (era[k] == k)
  {
    primes[l] = k;
    l++;
  }
  printf("%d == %d\n", l, nprimes);
  int ma = 0;
  int mb = 0;
  for (b = 3; b <= 999; b++)
    if (era[b] == b)
    for (a = -999; a <= 999; a++)
    {
      int n1 = test(a, b, primes, nprimes);
      int n2 = test(a, -b, primes, nprimes);
      if (n1 > max0)
      {
        max0 = n1;
        result = a * b;
        ma = a;
        mb = b;
      }
      if (n2 > max0)
      {
        max0 = n2;
        result = -a * b;
        ma = a;
        mb = -b;
      }
  }
  printf("%d %d\n%d\n%d\n", ma, mb, max0, result);
  return 0;
}


