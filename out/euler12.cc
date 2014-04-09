#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int eratostene(std::vector<int >& t, int max_){
  int n = 0;
  for (int i = 2 ; i < max_; i++)
    if (t.at(i) == i)
  {
    int j = i * i;
    n ++;
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

int find(int ndiv2){
  int maximumprimes = 10000;
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
  for (int n = 1 ; n <= 1000000; n ++)
  {
    int c = n + 2;
    std::vector<int > primesFactors( c );
    for (int m = 0 ; m < c; m++)
      primesFactors.at(m) = 0;
    int max_ = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
    primesFactors.at(2) --;
    int ndivs = 1;
    for (int i = 0 ; i <= max_; i ++)
      if (primesFactors.at(i) != 0)
      ndivs *= 1 + primesFactors.at(i);
    if (ndivs > ndiv2)
      return (n * (n + 1)) / 2;
    /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
  }
  return 0;
}


int main(void){
  int e = find(500);
  std::cout << e << "\n";
  return 0;
}

