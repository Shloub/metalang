#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int fact(int n){
  int prod = 1;
  for (int i = 2 ; i <= n; i ++)
    prod *= i;
  return prod;
}

void show(int lim, int nth){
  std::vector<int > t( lim );
  for (int i = 0 ; i < lim; i++)
    t.at(i) = i;
  std::vector<bool > pris( lim );
  for (int j = 0 ; j < lim; j++)
    pris.at(j) = false;
  for (int k = 1 ; k < lim; k++)
  {
    int n = fact(lim - k);
    int nchiffre = nth / n;
    nth %= n;
    for (int l = 0 ; l < lim; l++)
      if (!pris.at(l))
    {
      if (nchiffre == 0)
      {
        std::cout << l;
        pris.at(l) = true;
      }
      nchiffre --;
    }
  }
  for (int m = 0 ; m < lim; m++)
    if (!pris.at(m))
    std::cout << m;
  std::cout << "\n";
}


int main(void){
  show(10, 999999);
  return 0;
}

