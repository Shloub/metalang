#include <iostream>
#include <vector>

int main() {
  int c, b, a;
  for (int i = 1; i <= 3; i ++)
  {
    std::cin >> a >> b >> c;
    std::cout << "a = " << a << " b = " << b << "c =" << c << "\n";
  }
  std::vector<int> l(10);
  for (int d = 0; d < 10; d++)
  {
    std::cin >> l[d];
  }
  for (int j = 0; j <= 9; j ++)
    std::cout << l[j] << "\n";
}

