#include <iostream>
#include <vector>
std::vector<char> getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> c(line.begin(), line.end());
  return c;
}
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<char > read_char_line(int n){
  return getline();
}

int programme_candidat(std::vector<char >& tableau1, int taille1, std::vector<char >& tableau2, int taille2){
  int out_ = 0;
  for (int i = 0 ; i < taille1; i++)
  {
    out_ += tableau1.at(i) * i;
    std::cout << tableau1.at(i);
  }
  std::cout << "--\n";
  for (int j = 0 ; j < taille2; j++)
  {
    out_ += tableau2.at(j) * j * 100;
    std::cout << tableau2.at(j);
  }
  std::cout << "--\n";
  return out_;
}


int main(){
  int taille1 = read_int();
  std::vector<char > tableau1 = read_char_line(taille1);
  int taille2 = read_int();
  std::vector<char > tableau2 = read_char_line(taille2);
  std::cout << programme_candidat(tableau1, taille1, tableau2, taille2) << "\n";
  return 0;
}

