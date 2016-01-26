#include <iostream>
#include <vector>

int exp0(int a, int b) {
  if (b == 0)
    return 1;
  if (b % 2 == 0)
  {
    int o = exp0(a, b / 2);
    return o * o;
  }
  else
    return a * exp0(a, b - 1);
}


int main() {
  int a = 0;
  int b = 0;
  std::cin >> a >> b >> std::noskipws;
  std::cout << exp0(a, b);
}

