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
  std::vector<std::vector<int> *> *tableau = new std::vector<std::vector<int> *>( taille_y );
  for (int a = 0 ; a < taille_y; a++)
  {
    std::vector<int> *b = new std::vector<int>( taille_x );
    for (int c = 0 ; c < taille_x; c++)
    {
      std::cin >> b->at(c) >> std::skipws;
    }
    tableau->at(a) = b;
  }
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
}

