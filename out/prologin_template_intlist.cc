#include <iostream>
#include <vector>
int programme_candidat(std::vector<int> * tableau, int taille){
  int out_ = 0;
  for (int i = 0 ; i < taille; i++)
    out_ += tableau->at(i);
  return out_;
}


int main(){
  int b;
  std::cin >> b >> std::skipws;
  int taille = b;
  std::vector<int > *d = new std::vector<int>( taille );
  for (int e = 0 ; e < taille; e++)
  {
    std::cin >> d->at(e) >> std::skipws;
  }
  std::vector<int> * tableau = d;
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

