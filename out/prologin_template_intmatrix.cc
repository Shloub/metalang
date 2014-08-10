#include <iostream>
#include <vector>
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<int> * read_int_line(int n){
  std::vector<int > *tab = new std::vector<int>( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    std::cin >> t >> std::skipws;
    tab->at(i) = t;
  }
  return tab;
}

std::vector<std::vector<int> *> * read_int_matrix(int x, int y){
  std::vector<std::vector<int> * > *tab = new std::vector<std::vector<int> *>( y );
  for (int z = 0 ; z < y; z++)
    tab->at(z) = read_int_line(x);
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
  int taille_x = read_int();
  int taille_y = read_int();
  std::vector<std::vector<int> *> * tableau = read_int_matrix(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

