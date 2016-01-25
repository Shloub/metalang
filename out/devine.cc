#include <iostream>
#include <vector>
bool devine0(int nombre, std::vector<int> * tab, int len){
  int min0 = tab->at(0);
  int max0 = tab->at(1);
  for (int i = 2 ; i < len; i++)
  {
    if (tab->at(i) > max0 || tab->at(i) < min0)
      return false;
    if (tab->at(i) < nombre)
      min0 = tab->at(i);
    if (tab->at(i) > nombre)
      max0 = tab->at(i);
    if (tab->at(i) == nombre && len != i + 1)
      return false;
  }
  return true;
}


int main(){
  int tmp, len, nombre;
  std::cin >> nombre >> std::skipws >> len;
  std::vector<int> *tab = new std::vector<int>( len );
  for (int i = 0 ; i < len; i++)
  {
    std::cin >> tmp >> std::skipws;
    tab->at(i) = tmp;
  }
  if (devine0(nombre, tab, len))
    std::cout << "True";
  else
    std::cout << "False";
}

