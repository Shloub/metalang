#include <iostream>
#include <vector>
void foo(int i){
  std::cout << i << "\n";
}

void foobar(int i){
  std::cout << i << "\n" << "foobar";
}


int main(){
  int a = 0;
  std::cout << a << "\n";
  int b = 12;
  std::cout << b << "\n" << "foobar";
  int c = 1;
  std::cout << c << "\n";
  return 0;
}

