#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

int score(){
  std::cin >> std::skipws;
  int len = 0;
  std::cin >> len >> std::skipws;
  int sum = 0;
  for (int i = 1 ; i <= len; i ++)
  {
    char c = '_';
    std::cin >> c >> std::noskipws;
    sum += (c - 'A') + 1;
    /*		print c print " " print sum print " " */
  }
  return sum;
}


int main(){
  int sum = 0;
  int n = 0;
  std::cin >> n >> std::noskipws;
  for (int i = 1 ; i <= n; i ++)
    sum += i * score();
  std::cout << sum << "\n";
  return 0;
}

