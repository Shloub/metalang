#include <iostream>
#include <vector>

int montagnes0(std::vector<int> * tab, int len) {
  int max0 = 1;
  int j = 1;
  int i = len - 2;
  while (i >= 0)
  {
    int x = tab->at(i);
    while (j >= 0 && x > tab->at(len - j))
      j --;
    j++;
    tab->at(len - j) = x;
    if (j > max0)
      max0 = j;
    i --;
  }
  return max0;
}


int main() {
  int len = 0;
  std::cin >> len >> std::skipws;
  std::vector<int> *tab = new std::vector<int>( len );
  for (int i = 0; i < len; i++)
  {
    int x = 0;
    std::cin >> x >> std::skipws;
    tab->at(i) = x;
  }
  std::cout << montagnes0(tab, len);
}

