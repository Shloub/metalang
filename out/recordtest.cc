#include <iostream>
#include <vector>
class toto {
public:
  int foo;
  int bar;
};


int main(){
  toto * param = new toto();
  param->foo=0;
  param->bar=0;
  std::cin >> param->bar >> std::skipws >> param->foo >> std::noskipws;
  int a = param->bar + param->foo * param->bar;
  std::cout << a;
  return 0;
}

