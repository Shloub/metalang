#include <iostream>
#include <vector>

int main(){
  std::vector<int > *c = new std::vector<int>( 2 );
  for (int d = 0 ; d < 2; d++)
  {
    std::cin >> c->at(d) >> std::skipws;
  }
  std::vector<int> * t = c;
  std::cout << t->at(0) << " - " << t->at(1) << "\n";
  return 0;
}

