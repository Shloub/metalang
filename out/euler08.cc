#include <iostream>
#include <vector>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}


int main(){
  int i = 1;
  int g = 5;
  std::vector<int > last( g );
  for (int j = 0 ; j < g; j++)
  {
    char c = '_';
    std::cin >> c >> std::noskipws;
    int d = c - '0';
    i *= d;
    last.at(j) = d;
  }
  int max_ = i;
  int index = 0;
  int nskipdiv = 0;
  for (int k = 1 ; k <= 995; k ++)
  {
    char e = '_';
    std::cin >> e >> std::noskipws;
    int f = e - '0';
    if (f == 0)
    {
      i = 1;
      nskipdiv = 4;
    }
    else
    {
      i *= f;
      if (nskipdiv < 0)
        i /= last.at(index);
      nskipdiv --;
    }
    last.at(index) = f;
    index = (index + 1) % 5;
    max_ = max2(max_, i);
  }
  std::cout << max_ << "\n";
  return 0;
}

