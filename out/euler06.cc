#include <iostream>
#include <vector>

int main(){
  int lim = 100;
  int sum = (lim * (lim + 1)) / 2;
  int carressum = sum * sum;
  int sumcarres = (lim * (lim + 1) * (2 * lim + 1)) / 6;
  std::cout << carressum - sumcarres;
  return 0;
}

