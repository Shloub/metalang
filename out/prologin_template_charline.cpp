#include <iostream>
#include <vector>
int programme_candidat(std::vector<char >& tableau, int taille){
  int out0 = 0;
  for (int i = 0 ; i < taille; i++)
  {
    out0 += (int)(tableau[i]) * i;
    std::cout << tableau[i];
  }
  std::cout << "--\n";
  return out0;
}


int main(){
  int taille;
  std::cin >> taille >> std::skipws;
  std::vector<char > tableau(taille);
  for (int a = 0 ; a < taille; a++)
  {
    std::cin >> tableau[a] >> std::noskipws;
  }
  std::cin >> std::skipws;
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

