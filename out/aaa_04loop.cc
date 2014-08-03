#include <iostream>
#include <vector>

int main(){
  int j = 0;
  for (int k = 0 ; k <= 10; k ++)
  {
    j += k;
    std::cout << j << "\n";
  }
  int i = 4;
  while (i < 10)
  {
    std::cout << i;
    i ++;
    j += i;
  }
  std::cout << j << i;
  return 0;
}

