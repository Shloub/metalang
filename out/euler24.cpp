#include <iostream>
#include <vector>

int fact(int n) {
    int prod = 1;
    for (int i = 2; i <= n; i ++)
      prod *= i;
    return prod;
}


void show(int lim, int nth) {
    std::vector<int> t(lim);
    for (int i = 0; i < lim; i++)
      t[i] = i;
    std::vector<bool> pris(lim, false);
    for (int k = 1; k < lim; k++)
    {
        int n = fact(lim - k);
        int nchiffre = nth / n;
        nth %= n;
        for (int l = 0; l < lim; l++)
          if (!pris[l])
        {
            if (nchiffre == 0)
            {
                std::cout << l;
                pris[l] = true;
            }
            nchiffre --;
        }
    }
    for (int m = 0; m < lim; m++)
      if (!pris[m])
      std::cout << m;
    std::cout << "\n";
}


int main() {
    show(10, 999999);
}

