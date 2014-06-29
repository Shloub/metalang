#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
    return a;
  return b;
}

int eratostene(std::vector<int >& t, int max_){
  int n = 0;
  for (int i = 2 ; i < max_; i++)
    if (t.at(i) == i)
  {
    n ++;
    int j = i * i;
    if (j / i == i)
    {
      /* overflow test */
      while (j < max_ && j > 0)
      {
        t.at(j) = 0;
        j += i;
      }
    }
  }
  return n;
}


int main(){
  int maximumprimes = 1000001;
  std::vector<int > era( maximumprimes );
  for (int j = 0 ; j < maximumprimes; j++)
    era.at(j) = j;
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
  std::vector<int > sum( nprimes );
  for (int i_ = 0 ; i_ < nprimes; i_++)
    sum.at(i_) = primes.at(i_);
  int maxl = 0;
  bool process = true;
  int stop = maximumprimes - 1;
  int len = 1;
  int resp = 1;
  while (process)
  {
    process = false;
    for (int i = 0 ; i <= stop; i ++)
      if (i + len < nprimes)
    {
      sum.at(i) = sum.at(i) + primes.at(i + len);
      if (maximumprimes > sum.at(i))
      {
        process = true;
        if (era.at(sum.at(i)) == sum.at(i))
        {
          maxl = len;
          resp = sum.at(i);
        }
      }
      else
        stop = min2(stop, i);
    }
    len ++;
  }
  std::cout << resp << "\n" << maxl << "\n";
  return 0;
}

