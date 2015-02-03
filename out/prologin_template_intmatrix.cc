#include <iostream>
#include <vector>
int programme_candidat(std::vector<std::vector<int> *> * tableau, int x, int y){
  int out0 = 0;
  for (int i = 0 ; i < y; i++)
    for (int j = 0 ; j < x; j++)
      out0 += tableau->at(i)->at(j) * (i * 2 + j);
  return out0;
}


int main(){
  int taille_y, taille_x;
  std::cin >> taille_x >> std::skipws >> taille_y;
  std::vector<std::vector<int> * > *tableau = new std::vector<std::vector<int> *>( taille_y );
  for (int m = 0 ; m < taille_y; m++)
  {
    std::vector<int > *r = new std::vector<int>( taille_x );
    for (int p = 0 ; p < taille_x; p++)
    {
      std::cin >> r->at(p) >> std::skipws;
    }
    tableau->at(m) = r;
  }
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

