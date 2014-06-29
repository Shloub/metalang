#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int next_(int n){
  if ((n % 2) == 0)
    return n / 2;
  else
    return 3 * n + 1;
}

int find(int n, std::vector<int >& m){
  if (n == 1)
    return 1;
  else if (n >= 1000000)
    return 1 + find(next_(n), m);
  else if (m.at(n) != 0)
    return m.at(n);
  else
  {
    m.at(n) = 1 + find(next_(n), m);
    return m.at(n);
  }
}


int main(){
  int a = 1000000;
  std::vector<int > m( a );
  for (int j = 0 ; j < a; j++)
    m.at(j) = 0;
  int max_ = 0;
  int maxi = 0;
  for (int i = 1 ; i <= 999; i ++)
  {
    /* normalement on met 999999 mais ça dépasse les int32... */
    int n2 = find(i, m);
    if (n2 > max_)
    {
      max_ = n2;
      maxi = i;
    }
  }
  std::cout << max_ << "\n" << maxi << "\n";
  return 0;
}

