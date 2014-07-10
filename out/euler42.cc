#include <iostream>
#include <vector>
#include<cmath>
int isqrt(int c){
  return sqrt(c);
}

bool is_triangular(int n){
  /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
  int d = n * 2;
  int b = sqrt(d);
  int a = b;
  return a * (a + 1) == n * 2;
}

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
  if (is_triangular(sum))
    return 1;
  else
    return 0;
}


int main(){
  for (int i = 1 ; i <= 55; i ++)
    if (is_triangular(i))
  {
    std::cout << i << " ";
  }
  std::cout << "\n";
  int sum = 0;
  int n = 0;
  std::cin >> n >> std::noskipws;
  for (int i = 1 ; i <= n; i ++)
    sum += score();
  std::cout << sum << "\n";
  return 0;
}

