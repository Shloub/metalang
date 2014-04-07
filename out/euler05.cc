#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

std::vector<int > primesfactors(int n){
  int c = n + 1;
  std::vector<int > tab( c );
  for (int i = 0 ; i < c; i++)
    tab.at(i) = 0;
  int d = 2;
  while (n != 1 && d * d <= n)
    if ((n % d) == 0)
  {
    tab.at(d) = tab.at(d) + 1;
    n /= d;
  }
  else
    d ++;
  tab.at(n) = tab.at(n) + 1;
  return tab;
}


int main(void){
  int lim = 20;
  int e = lim + 1;
  std::vector<int > o( e );
  for (int m = 0 ; m < e; m++)
    o.at(m) = 0;
  for (int i = 1 ; i <= lim; i ++)
  {
    std::vector<int > t = primesfactors(i);
    for (int j = 1 ; j <= i; j ++)
      o.at(j) = max2(o.at(j), t.at(j));
  }
  int product = 1;
  for (int k = 1 ; k <= lim; k ++)
    for (int l = 1 ; l <= o.at(k); l ++)
      product *= k;
  std::cout << product << "\n";
  return 0;
}
