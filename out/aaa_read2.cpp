#include <iostream>
#include <vector>
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main(){
  int strlen, len;
  std::cin >> len >> std::skipws;
  std::cout << len << "=len\n";
  std::vector<int > tab(len);
  for (int a = 0 ; a < len; a++)
  {
    std::cin >> tab[a] >> std::skipws;
  }
  for (int i = 0 ; i < len; i++)
    std::cout << i << "=>" << tab[i] << " ";
  std::cout << "\n";
  std::vector<int > tab2(len);
  for (int b = 0 ; b < len; b++)
  {
    std::cin >> tab2[b] >> std::skipws;
  }
  for (int i_ = 0 ; i_ < len; i_++)
    std::cout << i_ << "==>" << tab2[i_] << " ";
  std::cin >> strlen >> std::skipws;
  std::cout << strlen << "=strlen\n";
  std::vector<char > tab4(strlen);
  for (int d = 0 ; d < strlen; d++)
  {
    std::cin >> tab4[d] >> std::noskipws;
  }
  std::cin >> std::skipws;
  for (int i3 = 0 ; i3 < strlen; i3++)
  {
    char tmpc = tab4[i3];
    int c = (int)(tmpc);
    std::cout << tmpc << ":" << c << " ";
    if (tmpc != ' ')
      c = (c - (int)('a') + 13) % 26 + (int)('a');
    tab4[i3] = (char)(c);
  }
  for (int j = 0 ; j < strlen; j++)
    std::cout << tab4[j];
  return 0;
}

