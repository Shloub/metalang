#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
/*
La suite de fibonaci
*/
int fibo_(int a, int b, int i){
  int out_ = 0;
  int a2 = a;
  int b2 = b;
  for (int j = 0 ; j <= i + 1; j ++)
  {
    out_ += a2;
    int tmp = b2;
    b2 += a2;
    a2 = tmp;
  }
  return out_;
}


int main(){
  int a = 0;
  int b = 0;
  int i = 0;
  std::cin >> a >> std::skipws >> b >> i >> std::noskipws;
  int c = fibo_(a, b, i);
  std::cout << c;
  return 0;
}

