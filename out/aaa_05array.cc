#include <iostream>
#include <vector>

int main(){
  int b = 5;
  std::vector<int > a( b );
  for (int i = 0 ; i < b; i++)
  {
    std::cout << i;
    a.at(i) = i * 2;
  }
  return 0;
}

