#include <iostream>
#include <vector>
int eratostene(std::vector<int> * t, int max0){
  int n = 0;
  for (int i = 2 ; i < max0; i++)
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

int fillPrimesFactors(std::vector<int> * t, int n, std::vector<int> * primes, int nprimes){
  for (int i = 0 ; i < nprimes; i++)
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

int sumdivaux2(std::vector<int> * t, int n, int i){
  while (i < n && t->at(i) == 0)
    i++;
  return i;
}

int sumdivaux(std::vector<int> * t, int n, int i){
  if (i > n)
    return 1;
  else if (t->at(i) == 0)
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1));
  else
  {
    int o = sumdivaux(t, n, sumdivaux2(t, n, i + 1));
    int out0 = 0;
    int p = i;
    for (int j = 1 ; j <= t->at(i); j ++)
    {
      out0 += p;
      p *= i;
    }
    return (out0 + 1) * o;
  }
}

int sumdiv(int nprimes, std::vector<int> * primes, int n){
  std::vector<int> *t = new std::vector<int>( n + 1 );
  std::fill(t->begin(), t->end(), 0);
  int max0 = fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max0, 0);
}


int main(){
  int maximumprimes = 1001;
  std::vector<int> *era = new std::vector<int>( maximumprimes );
  for (int j = 0 ; j < maximumprimes; j++)
    era->at(j) = j;
  int nprimes = eratostene(era, maximumprimes);
  std::vector<int> *primes = new std::vector<int>( nprimes );
  std::fill(primes->begin(), primes->end(), 0);
  int l = 0;
  for (int k = 2 ; k < maximumprimes; k++)
    if (era->at(k) == k)
  {
    primes->at(l) = k;
    l++;
  }
  std::cout << l << " == " << nprimes << "\n";
  int sum = 0;
  for (int n = 2 ; n <= 1000; n ++)
  {
    int other = sumdiv(nprimes, primes, n) - n;
    if (other > n)
    {
      int othersum = sumdiv(nprimes, primes, other) - other;
      if (othersum == n)
      {
        std::cout << other << " & " << n << "\n";
        sum += other + n;
      }
    }
  }
  std::cout << "\n" << sum << "\n";
}

