#include <iostream>
#include <vector>
std::vector<char> *getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    char c = std::cin.peek();
    if (c == '\n' || c == ' ') std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> *c = new std::vector<char>(line.begin(), line.end());
  return c;
}
std::vector<std::vector<char> *> * read_char_matrix(int x, int y){
  std::vector<std::vector<char> * > *tab = new std::vector<std::vector<char> *>( y );
  for (int z = 0 ; z < y; z++)
  {
    std::vector<char> * a = getline();
    tab->at(z) = a;
  }
  return tab;
}

int programme_candidat(std::vector<std::vector<char> *> * tableau, int taille_x, int taille_y){
  int out_ = 0;
  for (int i = 0 ; i < taille_y; i++)
  {
    for (int j = 0 ; j < taille_x; j++)
    {
      out_ += (int)(tableau->at(i)->at(j)) * (i + j * 2);
      std::cout << tableau->at(i)->at(j);
    }
    std::cout << "--\n";
  }
  return out_;
}


int main(){
  int e, c;
  std::cin >> c >> std::skipws;
  int taille_x = c;
  std::cin >> e >> std::skipws;
  int taille_y = e;
  std::vector<std::vector<char> *> * tableau = read_char_matrix(taille_x, taille_y);
  std::cout << programme_candidat(tableau, taille_x, taille_y) << "\n";
  return 0;
}

