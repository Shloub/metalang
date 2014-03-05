#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
bool devine_(int nombre, std::vector<int >& tab, int len){
  int min_ = tab.at(0);
  int max_ = tab.at(1);
  for (int i = 2 ; i < len; i++)
  {
    std::cout << i << " => ";
    int a = tab.at(i);
    std::cout << a << "\n";
    if (tab.at(i) > max_ || tab.at(i) < min_)
      return false;
    if (tab.at(i) < nombre)
      min_ = tab.at(i);
    if (tab.at(i) > nombre)
      max_ = tab.at(i);
    if (tab.at(i) == nombre && len != i + 1)
      return false;
  }
  return true;
}


int main(void){
  int nombre = 0;
  scanf("%d", &nombre);
  scanf("%*[ \t\r\n]c");
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  std::cout << nombre << " " << len << "\n";
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmp = 0;
    scanf("%d", &tmp);
    scanf("%*[ \t\r\n]c");
    std::cout << tmp << " ";
    tab.at(i) = tmp;
  }
  std::cout << "\n";
  bool b = devine_(nombre, tab, len);
  if (b)
    std::cout << "True";
  else
    std::cout << "False";
  return 0;
}

