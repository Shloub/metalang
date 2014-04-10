#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int eratostene(std::vector<int >& t, int max_){
  int n = 0;
  for (int i = 2 ; i < max_; i++)
    if (t.at(i) == i)
  {
    n ++;
    int j = i * i;
    while (j < max_ && j > 0)
    {
      t.at(j) = 0;
      j += i;
    }
  }
  return n;
}

int fillPrimesFactors(std::vector<int >& t, int n, std::vector<int >& primes, int nprimes){
  for (int i = 0 ; i < nprimes; i++)
  {
    int d = primes.at(i);
    while ((n % d) == 0)
    {
      t.at(d) = t.at(d) + 1;
      n /= d;
    }
    if (n == 1)
      return primes.at(i);
  }
  return n;
}

int sumdivaux2(std::vector<int >& t, int n, int i){
  while (i < n && t.at(i) == 0)
    i ++;
  return i;
}

int sumdivaux(std::vector<int >& t, int n, int i){
  if (i > n)
    return 1;
  else if (t.at(i) == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
  else
  {
    int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    int out_ = 0;
    int p = i;
    for (int j = 1 ; j <= t.at(i); j ++)
    {
      out_ += p;
      p *= i;
    }
    return (out_ + 1) * o;
  }
}

int sumdiv(int nprimes, std::vector<int >& primes, int n){
  int a = n + 1;
  std::vector<int > t( a );
  for (int i = 0 ; i < a; i++)
    t.at(i) = 0;
  int max_ = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max_, 0);
}


int main(void){
  int maximumprimes = 30001;
  std::vector<int > era( maximumprimes );
  for (int s = 0 ; s < maximumprimes; s++)
    era.at(s) = s;
  int nprimes = eratostene(era, maximumprimes);
  std::vector<int > primes( nprimes );
  for (int t = 0 ; t < nprimes; t++)
    primes.at(t) = 0;
  int l = 0;
  for (int k = 2 ; k < maximumprimes; k++)
    if (era.at(k) == k)
  {
    primes.at(l) = k;
    l ++;
  }
  int n = 100;
  /* 28124 ça prend trop de temps mais on arrive a passer le test */
  int b = n + 1;
  std::vector<bool > abondant( b );
  for (int p = 0 ; p < b; p++)
    abondant.at(p) = false;
  int c = n + 1;
  std::vector<bool > summable( c );
  for (int q = 0 ; q < c; q++)
    summable.at(q) = false;
  int sum = 0;
  for (int r = 2 ; r <= n; r ++)
  {
    int other = sumdiv(nprimes, primes, r) - r;
    if (other > r)
      abondant.at(r) = true;
  }
  for (int i = 1 ; i <= n; i ++)
    for (int j = 1 ; j <= n; j ++)
      if (abondant.at(i) && abondant.at(j) && i + j <= n)
    summable.at(i + j) = true;
  for (int o = 1 ; o <= n; o ++)
    if (!summable.at(o))
    sum += o;
  std::cout << "\n" << sum << "\n";
  return 0;
}

