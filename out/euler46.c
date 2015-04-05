#include <stdio.h>
#include <stdlib.h>

int eratostene(int* t, int max0){
  int i;
  int n = 0;
  for (i = 2 ; i < max0; i++)
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

int main(void){
  int m, i, j, i_, k, o, j_;
  int maximumprimes = 6000;
  int *era = calloc( maximumprimes , sizeof(int));
  for (j_ = 0 ; j_ < maximumprimes; j_++)
    era[j_] = j_;
  int nprimes = eratostene(era, maximumprimes);
  int *primes = calloc( nprimes , sizeof(int));
  for (o = 0 ; o < nprimes; o++)
    primes[o] = 0;
  int l = 0;
  for (k = 2 ; k < maximumprimes; k++)
    if (era[k] == k)
  {
    primes[l] = k;
    l ++;
  }
  printf("%d == %d\n", l, nprimes);
  int *canbe = calloc( maximumprimes , sizeof(int));
  for (i_ = 0 ; i_ < maximumprimes; i_++)
    canbe[i_] = 0;
  for (i = 0 ; i < nprimes; i++)
    for (j = 0 ; j < maximumprimes; j++)
    {
      int n = primes[i] + 2 * j * j;
      if (n < maximumprimes)
        canbe[n] = 1;
  }
  for (m = 1 ; m <= maximumprimes; m++)
  {
    int m2 = m * 2 + 1;
    if (m2 < maximumprimes && !canbe[m2])
    {
      printf("%d\n", m2);
    }
  }
  return 0;
}


