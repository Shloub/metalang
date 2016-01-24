#include <iostream>
#include <vector>

int main(){
  std::vector<int > t(2);
  for (int d = 0 ; d < 2; d++)
  {
    std::cin >> t[d] >> std::skipws;
  }
  std::cout << t[0] << " - " << t[1] << "\n";
  return 0;
}

