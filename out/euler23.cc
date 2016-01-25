#include <iostream>
#include <vector>

int eratostene(std::vector<int> * t, int max0) {
  int n = 0;
  for (int i = 2; i < max0; i++)
    if (t->at(i) == i)
  {
    n++;
    int j = i * i;
    while (j < max0 && j > 0)
    {
      t->at(j) = 0;
      j += i;
    }
  }
  return n;
}


int fillPrimesFactors(std::vector<int> * t, int n, std::vector<int> * primes, int nprimes) {
  for (int i = 0; i < nprimes; i++)
  {
    int d = primes->at(i);
    while (n % d == 0)
    {
      t->at(d) = t->at(d) + 1;
      n /= d;
    }
    if (n == 1)
      return primes->at(i);
  }
  return n;
}


int sumdivaux2(std::vector<int> * t, int n, int i) {
  while (i < n && t->at(i) == 0)
    i++;
  return i;
}


int sumdivaux(std::vector<int> * t, int n, int i) {
  if (i > n)
    return 1;
  else if (t->at(i) == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
  else
  {
    int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    int out0 = 0;
    int p = i;
    for (int j = 1; j <= t->at(i); j ++)
    {
      out0 += p;
      p *= i;
    }
    return (out0 + 1) * o;
  }
}


int sumdiv(int nprimes, std::vector<int> * primes, int n) {
  std::vector<int> *t = new std::vector<int>( n + 1 );
  std::fill(t->begin(), t->end(), 0);
  int max0 = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max0, 0);
}


int main() {
  int maximumprimes = 30001;
  std::vector<int> *era = new std::vector<int>( maximumprimes );
  for (int s = 0; s < maximumprimes; s++)
    era->at(s) = s;
  int nprimes = eratostene(era, maximumprimes);
  std::vector<int> *primes = new std::vector<int>( nprimes );
  std::fill(primes->begin(), primes->end(), 0);
  int l = 0;
  for (int k = 2; k < maximumprimes; k++)
    if (era->at(k) == k)
  {
    primes->at(l) = k;
    l++;
  }
  int n = 100;
  /* 28124 ça prend trop de temps mais on arrive a passer le test */
  std::vector<bool> *abondant = new std::vector<bool>( n + 1 );
  std::fill(abondant->begin(), abondant->end(), false);
  std::vector<bool> *summable = new std::vector<bool>( n + 1 );
  std::fill(summable->begin(), summable->end(), false);
  int sum = 0;
  for (int r = 2; r <= n; r ++)
  {
    int other = sumdiv(nprimes, primes, r) - r;
    if (other > r)
      abondant->at(r) = true;
  }
  for (int i = 1; i <= n; i ++)
    for (int j = 1; j <= n; j ++)
      if (abondant->at(i) && abondant->at(j) && i + j <= n)
    summable->at(i + j) = true;
  for (int o = 1; o <= n; o ++)
    if (!summable->at(o))
    sum += o;
  std::cout << "\n" << sum << "\n";
}

