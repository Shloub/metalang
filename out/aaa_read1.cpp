#include <iostream>
#include <vector>

int main(){
  std::vector<char > str(12);
  for (int a = 0 ; a < 12; a++)
  {
    std::cin >> str[a] >> std::noskipws;
  }
  std::cin >> std::skipws;
  for (int i = 0 ; i <= 11; i ++)
    std::cout << str[i];
  return 0;
}

