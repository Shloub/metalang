#include <iostream>
#include <vector>

int main(){
  int a = 1;
  int b = 2;
  int sum = 0;
  while (a < 4000000)
  {
    if (a % 2 == 0)
      sum += a;
    int c = a;
    a = b;
    b += c;
  }
  std::cout << sum << "\n";
  return 0;
}

