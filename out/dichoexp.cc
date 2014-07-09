#include <iostream>
#include <vector>
int exp_(int a, int b){
  if (b == 0)
    return 1;
  if ((b % 2) == 0)
  {
    int o = exp_(a, b / 2);
    return o * o;
  }
  else
    return a * exp_(a, b - 1);
}


int main(){
  int a = 0;
  int b = 0;
  std::cin >> a >> std::skipws >> b >> std::noskipws;
  std::cout << exp_(a, b);
  return 0;
}

