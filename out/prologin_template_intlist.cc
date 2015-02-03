#include <iostream>
#include <vector>
int programme_candidat(std::vector<int> * tableau, int taille){
  int out0 = 0;
  for (int i = 0 ; i < taille; i++)
    out0 += tableau->at(i);
  return out0;
}


int main(){
  int taille;
  std::cin >> taille >> std::skipws;
  std::vector<int > *tableau = new std::vector<int>( taille );
  for (int e = 0 ; e < taille; e++)
  {
    std::cin >> tableau->at(e) >> std::skipws;
  }
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

