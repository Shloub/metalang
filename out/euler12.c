#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int eratostene(int* t, int max_){
  int i;
  int n = 0;
  for (i = 2 ; i < max_; i++)
    if (t[i] == i)
  {
    int j = i * i;
    n ++;
    while (j < max_ && j > 0)
    {
      t[j] = 0;
      j += i;
    }
  }
  return n;
}

int fillPrimesFactors(int* t, int n, int* primes, int nprimes){
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
  return n;
}

int find(int ndiv2){
  int n, i, m, k, o, j;
  int maximumprimes = 110;
  int *era = malloc( maximumprimes * sizeof(int));
  for (j = 0 ; j < maximumprimes; j++)
    era[j] = j;
  int nprimes = eratostene(era, maximumprimes);
  int *primes = malloc( nprimes * sizeof(int));
  for (o = 0 ; o < nprimes; o++)
    primes[o] = 0;
  int l = 0;
  for (k = 2 ; k < maximumprimes; k++)
    if (era[k] == k)
  {
    primes[l] = k;
    l ++;
  }
  for (n = 1 ; n <= 10000; n++)
  {
    int c = n + 2;
    int *primesFactors = malloc( c * sizeof(int));
    for (m = 0 ; m < c; m++)
      primesFactors[m] = 0;
    int max_ = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
    primesFactors[2] --;
    int ndivs = 1;
    for (i = 0 ; i <= max_; i++)
      if (primesFactors[i] != 0)
      ndivs *= 1 + primesFactors[i];
    if (ndivs > ndiv2)
      return (n * (n + 1)) / 2;
    /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
  }
  return 0;
}

int main(void){
  printf("%d\n", find(500));
  return 0;
}


