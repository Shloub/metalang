#include <iostream>
#include <vector>
std::vector<std::vector<int> *> * read_int_matrix(int x, int y){
  int d;
  std::vector<std::vector<int> * > *tab = new std::vector<std::vector<int> *>( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<int > *b = new std::vector<int>( x );
    for (int c = 0 ; c < x; c++)
    {
      std::cin >> d >> std::skipws;
      b->at(c) = d;
    }
    tab->at(z) = b;
  }
  return tab;
}

int programme_candidat(std::vector<std::vector<int> *> * tableau, int x, int y){
  int out_ = 0;
  for (int i = 0 ; i < y; i++)
    for (int j = 0 ; j < x; j++)
      out_ += tableau->at(i)->at(j) * (i * 2 + j);
  return out_;
}


int main(){
  int h, f;
  std::cin >> f >> std::skipws;
  int taille_x = f;
  std::cin >> h >> std::skipws;
  int taille_y = h;
  std::vector<std::vector<int> *> * tableau = read_int_matrix(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

