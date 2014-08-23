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
int programme_candidat(std::vector<char> * tableau1, int taille1, std::vector<char> * tableau2, int taille2){
  int out_ = 0;
  for (int i = 0 ; i < taille1; i++)
  {
    out_ += (int)(tableau1->at(i)) * i;
    std::cout << tableau1->at(i);
  }
  std::cout << "--\n";
  for (int j = 0 ; j < taille2; j++)
  {
    out_ += (int)(tableau2->at(j)) * j * 100;
    std::cout << tableau2->at(j);
  }
  std::cout << "--\n";
  return out_;
}


int main(){
  int b = 0;
  std::cin >> b >> std::skipws;
  int taille1 = b;
  int d = 0;
  std::cin >> d >> std::skipws;
  int taille2 = d;
  std::vector<char> * tableau1 = getline();
  std::vector<char> * tableau2 = getline();
  std::cout << programme_candidat(tableau1, taille1, tableau2, taille2) << "\n";
  return 0;
}

