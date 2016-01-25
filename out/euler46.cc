#include <iostream>
#include <vector>

int eratostene(std::vector<int> * t, int max0) {
  int n = 0;
  for (int i = 2; i < max0; i++)
    if (t->at(i) == i)
  {
    n++;
    if (max0 / i > i)
    {
      int j = i * i;
      while (j < max0 && j > 0)
      {
        t->at(j) = 0;
        j += i;
      }
    }
  }
  return n;
}


int main() {
  int maximumprimes = 6000;
  std::vector<int> *era = new std::vector<int>( maximumprimes );
  for (int j_ = 0; j_ < maximumprimes; j_++)
    era->at(j_) = j_;
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
  std::cout << l << " == " << nprimes << "\n";
  std::vector<bool> *canbe = new std::vector<bool>( maximumprimes );
  std::fill(canbe->begin(), canbe->end(), false);
  for (int i = 0; i < nprimes; i++)
    for (int j = 0; j < maximumprimes; j++)
    {
      int n = primes->at(i) + 2 * j * j;
      if (n < maximumprimes)
        canbe->at(n) = true;
  }
  for (int m = 1; m <= maximumprimes; m ++)
  {
    int m2 = m * 2 + 1;
    if (m2 < maximumprimes && !canbe->at(m2))
      std::cout << m2 << "\n";
  }
}

