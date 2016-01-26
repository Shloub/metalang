#include <iostream>
#include <vector>

int main() {
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (int a = 1; a <= 1000; a ++)
      for (int b = a + 1; b <= 1000; b ++)
      {
          int c = 1000 - a - b;
          int a2b2 = a * a + b * b;
          int cc = c * c;
          if (cc == a2b2 && c > a)
            std::cout << a << "\n" << b << "\n" << c << "\n" << a * b * c << "\n";
    }
}

