#include <iostream>
#include <vector>

int main(){
  int b, a;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> a >> std::skipws >> b;
    std::cout << "a = " << a << " b = " << b << "\n";
  }
  return 0;
}

