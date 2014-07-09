#include <iostream>
#include <vector>
#include<cmath>
int isqrt(int c){
  return sqrt(c);
}


int main(){
  std::cout << isqrt(4) << " " << isqrt(16) << " " << isqrt(20) << " " << isqrt(1000) << " " << isqrt(500) << " " << isqrt(10) << " ";
  return 0;
}

