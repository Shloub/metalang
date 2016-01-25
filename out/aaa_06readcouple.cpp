#include <iostream>
#include <vector>

int main(){
  int b, a;
  for (int i = 1 ; i <= 3; i ++)
  {
    std::cin >> a >> std::skipws >> b;
    std::cout << "a = " << a << " b = " << b << "\n";
  }
  std::vector<int> l(10);
  for (int c = 0 ; c < 10; c++)
  {
    std::cin >> l[c] >> std::skipws;
  }
  for (int j = 0 ; j <= 9; j ++)
    std::cout << l[j] << "\n";
}

