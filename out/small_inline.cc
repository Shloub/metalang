#include <iostream>
#include <vector>

int main(){
  std::vector<int > *c = new std::vector<int>( 2 );
  for (int d = 0 ; d < 2; d++)
  {
    std::cin >> c->at(d) >> std::skipws;
  }
  std::cout << c->at(0) << " - " << c->at(1) << "\n";
  return 0;
}

