#include <iostream>
#include <vector>
int max2_(int a, int b) {
  if (a > b)
    return a;
  else
    return b;
}


int main() {
  char e, c;
  int i = 1;
  std::vector<int> last(5);
  for (int j = 0; j < 5; j++)
  {
    std::cin >> c >> std::noskipws;
    int d = (int)(c) - (int)('0');
    i *= d;
    last[j] = d;
  }
  int max0 = i;
  int index = 0;
  int nskipdiv = 0;
  for (int k = 1; k <= 995; k ++)
  {
    std::cin >> e >> std::noskipws;
    int f = (int)(e) - (int)('0');
    if (f == 0)
    {
      i = 1;
      nskipdiv = 4;
    }
    else
    {
      i *= f;
      if (nskipdiv < 0)
        i /= last[index];
      nskipdiv --;
    }
    last[index] = f;
    index = (index + 1) % 5;
    max0 = max2_(max0, i);
  }
  std::cout << max0 << "\n";
}

