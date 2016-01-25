#include <iostream>
#include <vector>

int main() {
  std::vector<int> *t = new std::vector<int>( 2 );
  for (int d = 0; d < 2; d++)
  {
    std::cin >> t->at(d) >> std::skipws;
  }
  std::cout << t->at(0) << " - " << t->at(1) << "\n";
}

