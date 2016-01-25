#include <iostream>
#include <vector>
#include<cmath>

int main() {
  int maximum = 1;
  int b0 = 2;
  int a = 408464633;
  int sqrtia = (int)sqrt(a);
  while (a != 1)
  {
    int b = b0;
    bool found = false;
    while (b <= sqrtia)
    {
      if (a % b == 0)
      {
        a /= b;
        b0 = b;
        b = a;
        sqrtia = (int)sqrt(a);
        found = true;
      }
      b++;
    }
    if (!found)
    {
      std::cout << a << "\n";
      a = 1;
    }
  }
}

