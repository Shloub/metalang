#include <iostream>
#include <vector>


/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/

int main(){
  int strlen = 0;
  std::cin >> strlen >> std::skipws;
  std::vector<char > tab4( strlen );
  for (int toto = 0 ; toto < strlen; toto++)
  {
    char tmpc = '_';
    std::cin >> tmpc >> std::noskipws;
    int c = tmpc;
    if (tmpc != ' ')
      c = ((c - 'a') + 13) % 26 + 'a';
    tab4.at(toto) = c;
  }
  for (int j = 0 ; j < strlen; j++)
  {
    char a = tab4.at(j);
    std::cout << a;
  }
  return 0;
}

