#include <iostream>
#include <vector>

int main(){
  int c, b, a;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> a >> std::skipws >> b >> c;
    std::cout << "a = " << a << " b = " << b << "c =" << c << "\n";
  }
  return 0;
}

