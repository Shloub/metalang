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

bool isPrime(int n, std::vector<int >& primes, int len){
  int i = 0;
  if (n < 0)
    n = -n;
  while (primes.at(i) * primes.at(i) < n)
  {
    if ((n % primes.at(i)) == 0)
      return false;
    i ++;
  }
  return true;
}

int test(int a, int b, std::vector<int >& primes, int len){
  for (int n = 0 ; n <= 200; n ++)
  {
    int j = n * n + a * n + b;
    if (!isPrime(j, primes, len))
      return n;
  }
  return 200;
}


int main(){
  int maximumprimes = 1000;
  std::vector<int > era( maximumprimes );
  for (int j = 0 ; j < maximumprimes; j++)
    era.at(j) = j;
  int result = 0;
  int max_ = 0;
  int nprimes = eratostene(era, maximumprimes);
  std::vector<int > primes( nprimes );
  for (int o = 0 ; o < nprimes; o++)
    primes.at(o) = 0;
  int l = 0;
  for (int k = 2 ; k < maximumprimes; k++)
    if (era.at(k) == k)
  {
    primes.at(l) = k;
    l ++;
  }
  std::cout << l << " == " << nprimes << "\n";
  int ma = 0;
  int mb = 0;
  for (int b = 3 ; b <= 999; b ++)
    if (era.at(b) == b)
    for (int a = -999 ; a <= 999; a ++)
    {
      int n1 = test(a, b, primes, nprimes);
      int n2 = test(a, -b, primes, nprimes);
      if (n1 > max_)
      {
        max_ = n1;
        result = a * b;
        ma = a;
        mb = b;
      }
      if (n2 > max_)
      {
        max_ = n2;
        result = -a * b;
        ma = a;
        mb = -b;
      }
  }
  std::cout << ma << " " << mb << "\n" << max_ << "\n" << result << "\n";
  return 0;
}

