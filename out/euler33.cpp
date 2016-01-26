#include <iostream>
#include <vector>
#include <algorithm>

int pgcd(int a, int b) {
    int c = std::min(a, b);
    int d = std::max(a, b);
    int reste = d % c;
    if (reste == 0)
      return c;
    else
      return pgcd(c, reste);
}


int main() {
    int top = 1;
    int bottom = 1;
    for (int i = 1; i <= 9; i ++)
      for (int j = 1; j <= 9; j ++)
        for (int k = 1; k <= 9; k ++)
          if (i != j && j != k)
    {
        int a = i * 10 + j;
        int b = j * 10 + k;
        if (a * k == i * b)
        {
            std::cout << a << "/" << b << "\n";
            top *= a;
            bottom *= b;
        }
    }
    std::cout << top << "/" << bottom << "\n";
    int p = pgcd(top, bottom);
    std::cout << "pgcd=" << p << "\n" << bottom / p << "\n";
}

