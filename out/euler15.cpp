#include <iostream>
#include <vector>

int main() {
  int n = 10;
  /* normalement on doit mettre 20 mais là on se tape un overflow */
  n++;
  std::vector<std::vector<int>> tab(n);
  for (int i = 0; i < n; i++)
  {
    std::vector<int> tab2(n, 0);
    tab[i] = tab2;
  }
  for (int l = 0; l < n; l++)
  {
    tab[n - 1][l] = 1;
    tab[l][n - 1] = 1;
  }
  for (int o = 2; o <= n; o ++)
  {
    int r = n - o;
    for (int p = 2; p <= n; p ++)
    {
      int q = n - p;
      tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
    }
  }
  for (int m = 0; m < n; m++)
  {
    for (int k = 0; k < n; k++)
      std::cout << tab[m][k] << " ";
    std::cout << "\n";
  }
  std::cout << tab[0][0] << "\n";
}

