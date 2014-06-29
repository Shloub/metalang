#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
#include<cmath>

int isqrt(int c){
  return sqrt(c);
}


int main(){
  int a = isqrt(4);
  std::cout << a << " ";
  int b = isqrt(16);
  std::cout << b << " ";
  int d = isqrt(20);
  std::cout << d << " ";
  int e = isqrt(1000);
  std::cout << e << " ";
  int f = isqrt(500);
  std::cout << f << " ";
  int g = isqrt(10);
  std::cout << g << " ";
  return 0;
}

