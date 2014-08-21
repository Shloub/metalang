#include <iostream>
#include <vector>
std::vector<char> *getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> *c = new std::vector<char>(line.begin(), line.end());
  return c;
}
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main(){
  int b = 0;
  std::cin >> b >> std::skipws;
  int a = b;
  int len = a;
  std::cout << len << "=len\n";
  std::vector<int > *e = new std::vector<int>( len );
  for (int f = 0 ; f < len; f++)
  {
    int g = 0;
    std::cin >> g >> std::skipws;
    e->at(f) = g;
  }
  std::vector<int> * d = e;
  std::vector<int> * tab = d;
  for (int i = 0 ; i < len; i++)
  {
    std::cout << i << "=>" << tab->at(i) << " ";
  }
  std::cout << "\n";
  std::vector<int > *k = new std::vector<int>( len );
  for (int l = 0 ; l < len; l++)
  {
    int m = 0;
    std::cin >> m >> std::skipws;
    k->at(l) = m;
  }
  std::vector<int> * h = k;
  std::vector<int> * tab2 = h;
  for (int i_ = 0 ; i_ < len; i_++)
  {
    std::cout << i_ << "==>" << tab2->at(i_) << " ";
  }
  int p = 0;
  std::cin >> p >> std::skipws;
  int o = p;
  int strlen = o;
  std::cout << strlen << "=strlen\n";
  std::vector<char> * q = getline();
  std::vector<char> * tab4 = q;
  for (int i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4->at(i3);
    int c = tmpc;
    std::cout << tmpc << ":" << c << " ";
    if (tmpc != ' ')
      c = ((c - 'a') + 13) % 26 + 'a';
    tab4->at(i3) = (char)(c);
  }
  for (int j = 0 ; j < strlen; j++)
    std::cout << tab4->at(j);
  return 0;
}

