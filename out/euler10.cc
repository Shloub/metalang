#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int eratostene(std::vector<int >& t, int max_){
  int sum = 0;
  for (int i = 2 ; i < max_; i++)
    if (t.at(i) == i)
  {
    sum += i;
    int j = i * i;
    /*
			detect overflow
			*/
    if (j / i == i)
      while (j < max_ && j > 0)
    {
      t.at(j) = 0;
      j += i;
    }
  }
  return sum;
}


int main(void){
  int n = 100000;
  /* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
  std::vector<int > t( n );
  for (int i = 0 ; i < n; i++)
    t.at(i) = i;
  t.at(1) = 0;
  int a = eratostene(t, n);
  std::cout << a << "\n";
  return 0;
}

