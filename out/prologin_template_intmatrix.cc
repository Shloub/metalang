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
  int q, h, f;
  std::cin >> f >> std::skipws;
  int taille_x = f;
  std::cin >> h >> std::skipws;
  int taille_y = h;
  std::vector<std::vector<int> * > *l = new std::vector<std::vector<int> *>( taille_y );
  for (int m = 0 ; m < taille_y; m++)
  {
    std::vector<int > *o = new std::vector<int>( taille_x );
    for (int p = 0 ; p < taille_x; p++)
    {
      std::cin >> q >> std::skipws;
      o->at(p) = q;
    }
    l->at(m) = o;
  }
  std::vector<std::vector<int> *> * tableau = l;
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

