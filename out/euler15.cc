#include <iostream>
#include <vector>

int main(){
  int n = 10;
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n ++;
  std::vector<std::vector<int > > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    std::vector<int > tab2( n );
    for (int j = 0 ; j < n; j++)
      tab2.at(j) = 0;
    tab.at(i) = tab2;
  }
  for (int l = 0 ; l < n; l++)
  {
    tab.at(n - 1).at(l) = 1;
    tab.at(l).at(n - 1) = 1;
  }
  for (int o = 2 ; o <= n; o ++)
  {
    int r = n - o;
    for (int p = 2 ; p <= n; p ++)
    {
      int q = n - p;
      tab.at(r).at(q) = tab.at(r + 1).at(q) + tab.at(r).at(q + 1);
    }
  }
  for (int m = 0 ; m < n; m++)
  {
    for (int k = 0 ; k < n; k++)
    {
      std::cout << tab.at(m).at(k) << " ";
    }
    std::cout << "\n";
  }
  std::cout << tab.at(0).at(0) << "\n";
  return 0;
}

