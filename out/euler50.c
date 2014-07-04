#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int eratostene(int* t, int max_){
  int n = 0;
  {
    int i;
    for (i = 2 ; i < max_; i++)
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
  }
  return n;
}

int main(void){
  int maximumprimes = 1000001;
  int *era = malloc( maximumprimes * sizeof(int));
  {
    int j;
    for (j = 0 ; j < maximumprimes; j++)
      era[j] = j;
  }
  int nprimes = eratostene(era, maximumprimes);
  int *primes = malloc( nprimes * sizeof(int));
  {
    int o;
    for (o = 0 ; o < nprimes; o++)
      primes[o] = 0;
  }
  int l = 0;
  {
    int k;
    for (k = 2 ; k < maximumprimes; k++)
      if (era[k] == k)
    {
      primes[l] = k;
      l ++;
    }
  }
  printf("%d == %d\n", l, nprimes);
  int *sum = malloc( nprimes * sizeof(int));
  {
    int i_;
    for (i_ = 0 ; i_ < nprimes; i_++)
      sum[i_] = primes[i_];
  }
  int maxl = 0;
  int process = 1;
  int stop = maximumprimes - 1;
  int len = 1;
  int resp = 1;
  while (process)
  {
    process = 0;
    {
      int i;
      for (i = 0 ; i <= stop; i++)
        if (i + len < nprimes)
      {
        sum[i] = sum[i] + primes[i + len];
        if (maximumprimes > sum[i])
        {
          process = 1;
          if (era[sum[i]] == sum[i])
          {
            maxl = len;
            resp = sum[i];
          }
        }
        else
          stop = min2(stop, i);
      }
    }
    len ++;
  }
  printf("%d\n%d\n", resp, maxl);
  return 0;
}


