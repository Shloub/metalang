#include <iostream>
#include <vector>
std::vector<std::vector<int> > read_int_matrix(int x, int y){
  std::vector<std::vector<int> > matrix(y);
  for (int i = 0; i < y; i++)
  {
    std::vector<int>& line = matrix[i];
    line.resize(x);
    for (int j = 0; j < x; j++)
    {
        std::cin >> line[j] >> std::skipws;
    }
  }
  return matrix;
}
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
  std::vector<std::vector<int > > tableau = read_int_matrix(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

