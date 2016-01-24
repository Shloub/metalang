#include <iostream>
#include <vector>
int programme_candidat(std::vector<char >& tableau1, int taille1, std::vector<char >& tableau2, int taille2){
  int out0 = 0;
  for (int i = 0 ; i < taille1; i++)
  {
    out0 += (int)(tableau1[i]) * i;
    std::cout << tableau1[i];
  }
  std::cout << "--\n";
  for (int j = 0 ; j < taille2; j++)
  {
    out0 += (int)(tableau2[j]) * j * 100;
    std::cout << tableau2[j];
  }
  std::cout << "--\n";
  return out0;
}


int main(){
  int taille2, taille1;
  std::cin >> taille1 >> std::skipws;
  std::vector<char > tableau1(taille1);
  for (int a = 0 ; a < taille1; a++)
  {
    std::cin >> tableau1[a] >> std::noskipws;
  }
  std::cin >> std::skipws >> taille2;
  std::vector<char > tableau2(taille2);
  for (int b = 0 ; b < taille2; b++)
  {
    std::cin >> tableau2[b] >> std::noskipws;
  }
  std::cin >> std::skipws;
  std::cout << programme_candidat(tableau1, taille1, tableau2, taille2) << "\n";
  return 0;
}

