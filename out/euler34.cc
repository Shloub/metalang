#include <iostream>
#include <vector>

int main() {
    std::vector<int> *f = new std::vector<int>( 10 );
    std::fill(f->begin(), f->end(), 1);
    for (int i = 1; i <= 9; i ++)
    {
        f->at(i) *= i * f->at(i - 1);
        std::cout << f->at(i) << " ";
    }
    int out0 = 0;
    std::cout << "\n";
    for (int a = 0; a <= 9; a ++)
      for (int b = 0; b <= 9; b ++)
        for (int c = 0; c <= 9; c ++)
          for (int d = 0; d <= 9; d ++)
            for (int e = 0; e <= 9; e ++)
              for (int g = 0; g <= 9; g ++)
              {
                  int sum = f->at(a) + f->at(b) + f->at(c) + f->at(d) + f->at(e) + f->at(g);
                  int num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                  if (a == 0)
                  {
                      sum --;
                      if (b == 0)
                      {
                          sum --;
                          if (c == 0)
                          {
                              sum --;
                              if (d == 0)
                                sum --;
                          }
                      }
                  }
                  if (sum == num && sum != 1 && sum != 2)
                  {
                      out0 += num;
                      std::cout << num << " ";
                  }
    }
    std::cout << "\n" << out0 << "\n";
}

