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

int programme_candidat(std::vector<int> * tableau, int taille){
  int out_ = 0;
  for (int i = 0 ; i < taille; i++)
    out_ += tableau->at(i);
  return out_;
}


int main(){
  int taille = read_int();
  std::vector<int> * tableau = read_int_line(taille);
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

