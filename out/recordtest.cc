#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
class toto {
public:
  int foo;
  int bar;
};


int main(void){
  toto * param = new toto();
  param->foo=0;
  param->bar=0;
  scanf("%d", &param->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &param->foo);
  int a = param->bar + param->foo * param->bar;
  std::cout << a;
  return 0;
}

