#include <iostream>
#include <vector>
int programme_candidat(std::vector<std::vector<int > >& tableau, int x, int y){
  int out0 = 0;
  for (int i = 0 ; i < y; i++)
    for (int j = 0 ; j < x; j++)
      out0 += tableau[i][j] * (i * 2 + j);
  return out0;
}


int main(){
  int taille_y, taille_x;
  std::cin >> taille_x >> std::skipws >> taille_y;
  std::vector<std::vector<int > > tableau(taille_y);
  for (int a = 0 ; a < taille_y; a++)
  {
    std::vector<int > b(taille_x);
    for (int c = 0 ; c < taille_x; c++)
    {
      std::cin >> b[c] >> std::skipws;
    }
    tableau[a] = b;
  }
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

