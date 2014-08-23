#include<stdio.h>
#include<stdlib.h>

int eratostene(int* t, int max_){
  int n = 0;
  {
    int i;
    for (i = 2 ; i < max_; i++)
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
  }
  return n;
}

int fillPrimesFactors(int* t, int n, int* primes, int nprimes){
  {
    int i;
    for (i = 0 ; i < nprimes; i++)
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
  }
  return n;
}

int sumdivaux2(int* t, int n, int i){
  while (i < n && t[i] == 0)
    i ++;
  return i;
}

int sumdivaux(int* t, int n, int i){
  if (i > n)
    return 1;
  else if (t[i] == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
  else
  {
    int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    int out_ = 0;
    int p = i;
    {
      int j;
      for (j = 1 ; j <= t[i]; j++)
      {
        out_ += p;
        p *= i;
      }
    }
    return (out_ + 1) * o;
  }
}

int sumdiv(int nprimes, int* primes, int n){
  int *t = malloc( (n + 1) * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n + 1; i++)
      t[i] = 0;
  }
  int max_ = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max_, 0);
}

int main(void){
  int maximumprimes = 1001;
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
  int sum = 0;
  {
    int n;
    for (n = 2 ; n <= 1000; n++)
    {
      int other = sumdiv(nprimes, primes, n) - n;
      if (other > n)
      {
        int othersum = sumdiv(nprimes, primes, other) - other;
        if (othersum == n)
        {
          printf("%d & %d\n", other, n);
          sum += other + n;
        }
      }
    }
  }
  printf("\n%d\n", sum);
  return 0;
}


