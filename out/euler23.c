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
  int maximumprimes = 30001;
  int *era = malloc( maximumprimes * sizeof(int));
  {
    int s;
    for (s = 0 ; s < maximumprimes; s++)
      era[s] = s;
  }
  int nprimes = eratostene(era, maximumprimes);
  int *primes = malloc( nprimes * sizeof(int));
  {
    int t;
    for (t = 0 ; t < nprimes; t++)
      primes[t] = 0;
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
  int n = 100;
  /* 28124 ça prend trop de temps mais on arrive a passer le test */
  int *abondant = malloc( (n + 1) * sizeof(int));
  {
    int p;
    for (p = 0 ; p < n + 1; p++)
      abondant[p] = 0;
  }
  int *summable = malloc( (n + 1) * sizeof(int));
  {
    int q;
    for (q = 0 ; q < n + 1; q++)
      summable[q] = 0;
  }
  int sum = 0;
  {
    int r;
    for (r = 2 ; r <= n; r++)
    {
      int other = sumdiv(nprimes, primes, r) - r;
      if (other > r)
        abondant[r] = 1;
    }
  }
  {
    int i;
    for (i = 1 ; i <= n; i++)
      {
      int j;
      for (j = 1 ; j <= n; j++)
        if (abondant[i] && abondant[j] && i + j <= n)
        summable[i + j] = 1;
    }
  }
  {
    int o;
    for (o = 1 ; o <= n; o++)
      if (!summable[o])
      sum += o;
  }
  printf("\n%d\n", sum);
  return 0;
}


